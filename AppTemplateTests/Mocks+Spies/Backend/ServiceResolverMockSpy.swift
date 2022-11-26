//
//  ServiceResolverMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class ServiceResolverMockSpy: ServiceResolving {

    var services: (networking: NetworkingServing,
                   persistence: PersistenceServing,
                   encryption: EncryptionServing) = (networking: NetworkingServiceMockSpy(),
                                                     persistence: PersistenceServiceMockSpy(),
                                                     encryption: EncryptionServiceMockSpy())

    static var resolveNetworkingServiceCallCount = 0
    static var resolveNetworkingServiceReturn = NetworkingServiceMockSpy()
    class func resolveNetworkingService() -> NetworkingServing {
        resolveNetworkingServiceCallCount += 1
        return resolveNetworkingServiceReturn
    }

    static var resolvePersistenceServiceCallCount = 0
    static var resolvePersistenceServiceArg: NetworkingServing?
    static var resolvePersistenceServiceReturn = PersistenceServiceMockSpy()
    class func resolvePersistenceService(networkingService: NetworkingServing) -> PersistenceServing {
        resolvePersistenceServiceCallCount += 1
        resolvePersistenceServiceArg = networkingService
        return resolvePersistenceServiceReturn
    }

    static var resolveEncryptionServiceCallCount = 0
    static var resolveEncryptionServiceArg: PersistenceServing?
    static var resolveEncryptionServiceReturn = EncryptionServiceMockSpy()
    class func resolveEncryptionService(persistenceService: PersistenceServing) -> EncryptionServing {
        resolveEncryptionServiceCallCount += 1
        resolveEncryptionServiceArg = persistenceService
        return resolveEncryptionServiceReturn
    }
}
