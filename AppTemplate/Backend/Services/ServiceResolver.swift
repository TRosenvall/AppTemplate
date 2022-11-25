//
//  ServiceResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

protocol ServiceResolving {

    /// A variable holding a list of all available services
    var services: (networking: NetworkingServing,
                   persistence: PersistenceServing,
                   encryption: EncryptionServing) { get set }
    
    /// Resolves a copy of `NetworkingServing`
    static func resolveNetworkingService() -> NetworkingServing

    /// Resolves a copy of `PersistenceServing`
    static func resolvePersistenceService(networkingService: NetworkingServing) -> PersistenceServing

    /// Resolves a copy of `EncryptionServing`
    static func resolveEncryptionService(persistenceService: PersistenceServing) -> EncryptionServing
}

class ServiceResolver: ServiceResolving {

    // MARK: - Properties
    var services: (networking: NetworkingServing,
                   persistence: PersistenceServing,
                   encryption: EncryptionServing)

    // MARK: - Initializers
    init() {
        let networking = ServiceResolver.resolveNetworkingService()
        let persistence = ServiceResolver.resolvePersistenceService(networkingService: networking)
        let encryption = ServiceResolver.resolveEncryptionService(persistenceService: persistence)
        services = (networking: networking,
                    persistence: persistence,
                    encryption: encryption)
    }

    // MARK: - ServiceResolving Functions
    class func resolveNetworkingService() -> NetworkingServing {
        let builder = NetworkingBuilder()
        return builder.buildService()
    }

    class func resolvePersistenceService(networkingService: NetworkingServing) -> PersistenceServing {
        let builder = PersistenceBuilder(networkingService: networkingService)
        return builder.buildService()
    }

    class func resolveEncryptionService(persistenceService: PersistenceServing) -> EncryptionServing {
        let builder = EncryptionBuilder(persistenceService: persistenceService)
        return builder.buildService()
    }

    // MARK: - Helper Functions
}
