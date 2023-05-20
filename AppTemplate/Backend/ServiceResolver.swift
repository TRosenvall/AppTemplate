//
//  ServiceResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

typealias ServiceLoadProperty = (loadPriority: Int, service: any Service)

actor ServiceResolver: ServiceResolving {

    // MARK: - Properties

    static var shared: ServiceResolving = ServiceResolver()

    var activeServices: [UtilityType.Service: any Service] = [:]

    // MARK: - Initializers
    init() {}

    func configureServices() async -> [Error] {
        var exceptions: [Error] = []
        var servicesWithLoadOrder: [Int: any Service] = [:]

        // Initialize Services
        await UtilityType.Service.allCases.asyncForEach { serviceType in
            let serviceLoadProperty = self.initializeService(ofType: serviceType)
            servicesWithLoadOrder.updateValue(serviceLoadProperty.service, forKey: serviceLoadProperty.loadPriority)
        }

        // Validate no same load priorities
        if servicesWithLoadOrder.count != UtilityType.Service.allCases.count {
            fatalError("All Services must have a unique load priority.")
        }

        // Get and order the load priorities
        var loadPriorities: [Int] = []
        for property in servicesWithLoadOrder {
            loadPriorities.append(property.key)
        }
        loadPriorities.sort()

        // Configure Service Entities
        for loadPriority in loadPriorities {
            let service = servicesWithLoadOrder[loadPriority]
            do {
                try await service?.entityController?.configure()
            } catch {
                exceptions.append(error)
            }
        }

        // Add to activeServices dictionary
        await loadPriorities.asyncForEach { loadPriority in
            do {
                guard let service = servicesWithLoadOrder[loadPriority] else {
                    throw AppErrors.Service.ServiceNotFound.logError()
                }
                let state = try await service.state
                if state {
                    self.activeServices.updateValue(service, forKey: service.utility as! UtilityType.Service)
                }
            } catch {
                exceptions.append(error)
            }
        }
        return exceptions
    }

    func configureService(ofType serviceType: UtilityType.Service) async throws -> any Service {
        let service = initializeService(ofType: serviceType).service
        try await service.entityController?.configure()
        self.activeServices.updateValue(service, forKey: serviceType)
        return service
    }

    // MARK: - ToggleServiceDelegate Functions
    func toggleService(ofType serviceType: UtilityType.Service) async throws {
        // Initialize service if it's off
        let service = try await configureService(ofType: serviceType)
        // Update the `serviceState` variable to indicate that it should be on.
        try await service.toggleState()
        // Get the new state
        let newState = try await service.state
        // Deinitialize the service if it's getting turned off.
        if newState {
            activeServices.updateValue(service, forKey: serviceType)
        } else {
            activeServices.removeValue(forKey: serviceType)
        }
    }

    // MARK: - ServiceResolving Functions
    func resolveService(ofType serviceType: UtilityType.Service) -> (any Service)? {
        if let service = activeServices[serviceType] {
            return service
        }
        return nil
    }

    // MARK: - Helper Functions
    func initializeService(ofType serviceType: UtilityType.Service) -> ServiceLoadProperty {
        var loadPriority: Int
        var service: any Service
        switch serviceType {
        case .Persistence:
            service = PersistenceService()
            loadPriority = PersistenceService.VariableSet.loadPriority
        case .Coding:
            service = CodingService()
            loadPriority = CodingService.VariableSet.loadPriority
        case .Encryption:
            service = EncryptionService()
            loadPriority = EncryptionService.VariableSet.loadPriority
        case .DataRouting:
            service = DataRoutingService()
            loadPriority = DataRoutingService.VariableSet.loadPriority
        case .Networking:
            service = NetworkingService()
            loadPriority = NetworkingService.VariableSet.loadPriority
        case .Analytics:
            service = AnalyticsService()
            loadPriority = AnalyticsService.VariableSet.loadPriority
        }
        activeServices.updateValue(service, forKey: serviceType)
        return (loadPriority: loadPriority, service: service)
    }
}
