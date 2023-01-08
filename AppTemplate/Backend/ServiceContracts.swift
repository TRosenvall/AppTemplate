//
//  ServiceContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

/// `Persistence` - This service is used to send and retrieve data, either to the device or to the cloud
/// `Coding` - This service is used to encode and decode data
/// `Encryption` - This service is used to encrypt and decrypt data
/// `DataRouting` - This service is used to ensure data is being properly directed and ensures that each utility has
/// it's entity when needed.
/// `Networking` - This service is used to route all network calls if needed and return either the needed data or errors
/// `Authentication` - TODO - This service is used to authenticate any user with the app's web authentication
/// `DataExpiration` - TODO - This service is used to expire data after an amount of time. Such as retiring login tokens.

///------

protocol Service {
    var entityController: (any ModelControlling)? { get set }
    func buildEntity(delegate: ServiceResolvingDelegate, listener: ServiceDelegate?) throws
}

///------

protocol ServiceResolvingDelegate {
    func toggle(service: UtilityType.Service, to state: Bool)

    func resolveService(ofType serviceType: UtilityType.Service) -> Service?
}

protocol ServiceResolving: ServiceResolvingDelegate, ServiceDelegate {

    var persistenceService: PersistenceServing { get }
    var codingService: CodingServing { get }
    var encryptionService: EncryptionServing { get }
    var dataRoutingService: DataRoutingServing { get }
    var networkingService: NetworkingServing { get }

    var subscribers: [ServiceResolvingBroadcaster]? { get set }
    var activeServices: [UtilityType.Service: Service] { get set }

    /// Resolves a copy of `PersistenceServing`
    func resolvePersistenceService() -> PersistenceServing?

    /// Resolves a copy of `CodingServing`
    func resolveCodingService() -> CodingServing?

    /// Resolves a copy of `EncryptionServing`
    func resolveEncryptionService() -> EncryptionServing?

    /// Resolves a copy of `DataRoutingServing`
    func resolveDataRoutingService() -> DataRoutingServing?

    /// Resolves a copy of `NetworkingServing`
    func resolveNetworkingService() -> NetworkingServing?
}

///------

