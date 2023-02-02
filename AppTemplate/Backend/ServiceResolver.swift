//
//  ServiceResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

actor ServiceResolver: ServiceResolving, ToggleServiceDelegate {

    // MARK: - Properties

    static var shared: ServiceResolving = ServiceResolver()

    var activeServices: [UtilityType.Service: Service] = [:]

    // MARK: - Initializers
    init() {}

    func configureServices() async -> [Error] {
        var exceptions: [Error] = []
        await UtilityType.Service.allCases.asyncForEach { serviceType in
            do {
                try await self.configureService(ofType: serviceType)
            } catch {
                exceptions.append(error)
            }
        }
        return exceptions
    }

    // MARK: - ToggleServiceDelegate Functions
    func toggle(service serviceType: UtilityType.Service, to isOn: Bool) async throws {
        if isOn {
            // Initialize service if it's off
            try await configureService(ofType: serviceType)
        } else {
            // Deinitialize the service if it's getting turned off.
            // ARC retain cycles - Does this hold artifacts of the service if it's set to nil here? Look into this.
            activeServices.removeValue(forKey: serviceType)
        }
    }

    // MARK: - ServiceResolving Functions
    func resolveService(ofType serviceType: UtilityType.Service) -> (any Service)? {
        if let service: Service = activeServices[serviceType] {
            return service
        }
        return nil
    }

    // MARK: - Helper Functions
    /// Used to initialize individual services. If new services are added, this function will throw an error reminding
    /// to update here.
    private func configureService(ofType serviceType: UtilityType.Service) async throws {
        var service: any Service
        switch serviceType {
        case .Persistence: service = try await PersistenceService()
        case .Coding: service = try await CodingService()
        case .Encryption: service = try await EncryptionService()
        case .DataRouting: service = try await DataRoutingService()
        case .Networking: service = try await NetworkingService()
        }
        activeServices.updateValue(service, forKey: serviceType)
    }
}
