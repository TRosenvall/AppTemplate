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
        print("110. Initializing Services")
        print("--------------------------")
        print("--------------------------")
        await UtilityType.Service.allCases.asyncForEach { serviceType in
            print("111. Service: \(serviceType)")
            let serviceLoadProperty = self.initializeService(ofType: serviceType)
            servicesWithLoadOrder.updateValue(serviceLoadProperty.service, forKey: serviceLoadProperty.loadPriority)
        }

        // Validate no same load priorities
        print("112. Validating load priorities")
        print("0000000000000000000000000000000")
        print("0000000000000000000000000000000")
        if servicesWithLoadOrder.count != UtilityType.Service.allCases.count {
            fatalError("All Services must have a unique load priority.")
        }

        // Get and order the load priorities
        var loadPriorities: [Int] = []
        for property in servicesWithLoadOrder {
            print("113. Service: \(property.value.utility), Load Priority: \(property.key)")
            loadPriorities.append(property.key)
        }
        print("114. Load Priorities: \(loadPriorities)")
        loadPriorities.sort()
        print("115. Sorted Load Priorities: \(loadPriorities)")

        // Configure Service Entities
        print("120. Configuring Service Entities")
        print("121. ServicesWithLoadOrder: \(servicesWithLoadOrder)")
        print("122. Active Services: \(self.activeServices)")
        for loadPriority in loadPriorities {
            let service = servicesWithLoadOrder[loadPriority]
            print("==========================")
            print("==========================")
            do {
                print("123. Configuring service: \(String(describing: service?.utility))")
                try await service?.entityController?.configure()
            } catch {
                print("124. Excpetion Caught: \(error)")
                exceptions.append(error)
            }
        }
        print("125. Exceptions found so far: \(exceptions)")

        // Add to activeServices dictionary
        print("130. Updating active services")
        await loadPriorities.asyncForEach { loadPriority in
            do {
                guard let service = servicesWithLoadOrder[loadPriority] else {
                    throw AppErrors.Service.ServiceNotFound.logError()
                }
                print("-=-=-=-=-=-=-=-=-=-=-=-=-=")
                print("=-=-=-=-=-=-=-=-=-=-=-=-=-")
                print("131. Updating \(service.utility)")
                let state = try await service.state
                print("132. Service is on: \(state)")
                if state {
                    self.activeServices.updateValue(service, forKey: service.utility as! UtilityType.Service)
                }
                print("133. Updated Service successfully")
            } catch {
                print("134. Caught Exception: \(error)")
                exceptions.append(error)
            }
        }
        print("135. Found exceptions \(exceptions)")
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
        print("600. Getting \(serviceType) from activeServices array.")
        if let service = activeServices[serviceType] {
            print("601. Retrieved service \(service.utility)")
            return service
        }
        print("602. Unable to retrieve service.")
        return nil
    }

    // MARK: - Helper Functions
    func initializeService(ofType serviceType: UtilityType.Service) -> ServiceLoadProperty {
        print("200. Initializing service: \(serviceType)")
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
        print("201. Initialized \(service.utility)")
        activeServices.updateValue(service, forKey: serviceType)
        print("202. Updated active services: \(activeServices)")
        return (loadPriority: loadPriority, service: service)
    }
}
