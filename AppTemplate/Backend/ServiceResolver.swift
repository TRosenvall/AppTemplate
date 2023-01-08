//
//  ServiceResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class ServiceResolver: ServiceResolving {

    // MARK: - Properties
    static var shared = ServiceResolver()

    // These five services compose the core services and are used in persisting data properly. While services should always
    // be called from the active services list, these services will be required to exist here in order to facilitate core
    // service functions. All services will be initialized at app launch and held here.
    internal var persistenceService: PersistenceServing
    internal var codingService: CodingServing
    internal var encryptionService: EncryptionServing
    internal var dataRoutingService: DataRoutingServing
    internal var networkingService: NetworkingServing

    var subscribers: [ServiceResolvingBroadcaster]? = []
    var activeServices: [UtilityType.Service: Service] = [:]

    // MARK: - Initializers
    init() {
        do {
            self.persistenceService = PersistenceService()
            self.codingService = CodingService()
            self.encryptionService = EncryptionService()
            self.dataRoutingService = DataRoutingService()
            self.networkingService = NetworkingService()

            try self.persistenceService.buildEntity(delegate: self, listener: self)
            try self.codingService.buildEntity(delegate: self, listener: self)
            try self.encryptionService.buildEntity(delegate: self, listener: self)
            try self.dataRoutingService.buildEntity(delegate: self, listener: self)
            try self.networkingService.buildEntity(delegate: self, listener: self)

            activeServices.updateValue(persistenceService, forKey: .Persistence)
            activeServices.updateValue(codingService, forKey: .Coding)
            activeServices.updateValue(encryptionService, forKey: .Encryption)
            activeServices.updateValue(dataRoutingService, forKey: .DataRouting)
            activeServices.updateValue(networkingService, forKey: .Networking)
        } catch {
            fatalError("All services must be initialized and built")
        }
    }

    // MARK: - ServiceDelegate Functions
    func subscribe(_ object: ServiceResolvingBroadcaster) {
        self.subscribers?.append(object)
    }

    // MARK: - ServiceResolvingDelegate Functions
    func toggle(service: UtilityType.Service, to isOn: Bool) {
        if isOn {
            let entry = getService(from: service)
            activeServices.updateValue(entry, forKey: service)
        } else {
            activeServices.removeValue(forKey: service)
        }
        subscribers?.forEach { subscriber in
            Task {
                await subscriber.updateDependencies(from: self)
            }
        }
    }

    // MARK: - ServiceResolving Functions
    //These five are core services required to start, run, and close the app. These functions will always be run first.
    func resolveService(ofType serviceType: UtilityType.Service) -> Service? {
        switch serviceType {
        case .Persistence: return self.resolvePersistenceService()
        case .Coding: return self.resolveCodingService()
        case .Encryption: return self.resolveEncryptionService()
        case .DataRouting: return self.resolveDataRoutingService()
        case .Networking: return self.resolveNetworkingService()
        }
    }

    func resolvePersistenceService() -> PersistenceServing? {
        if let persistenceService: PersistenceService = activeServices[.Persistence] as? PersistenceService {
            persistenceService.networkingService = resolveNetworkingService()
            return persistenceService
        }
        return nil
    }

    func resolveCodingService() -> CodingServing? {
        if let codingService: CodingService = activeServices[.Coding] as? CodingService {
            return codingService
        }
        return nil
    }

    func resolveEncryptionService() -> EncryptionServing? {
        if let encryptionService: EncryptionService = activeServices[.Encryption] as? EncryptionService {
            return encryptionService
        }
        return nil
    }

    func resolveDataRoutingService() -> DataRoutingServing? {
        if let dataRoutingService: DataRoutingService = activeServices[.DataRouting] as? DataRoutingService {
            dataRoutingService.persistenceService = resolvePersistenceService()
            dataRoutingService.codingService = resolveCodingService()
            dataRoutingService.encryptionService = resolveEncryptionService()
            return dataRoutingService
        }
        return nil
    }

    func resolveNetworkingService() -> NetworkingServing? {
        if let networkingService: NetworkingService = activeServices[.Networking] as? NetworkingService {
            return networkingService
        }
        return nil
    }

    // MARK: - Helper Functions
    // Used to retrieve the actual initialized services, whether active or otherwise.
    func getService(from service: UtilityType.Service) -> Service {
        switch service {
        case .Persistence: return self.persistenceService
        case .Coding: return self.codingService
        case .Encryption: return self.encryptionService
        case .DataRouting: return self.dataRoutingService
        case .Networking: return self.networkingService
        }
    }
}
