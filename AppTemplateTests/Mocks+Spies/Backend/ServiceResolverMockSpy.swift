//
//  ServiceResolverMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class ServiceResolverMockSpy: ServiceResolving {

    var resolveNetworkingServiceCallCount = 0
    var resolveNetworkingServiceReturn = NetworkingServiceMockSpy()
    func resolveNetworkingService() -> NetworkingServing {
        resolveNetworkingServiceCallCount += 1
        return resolveNetworkingServiceReturn
    }

    var resolvePersistenceServiceCallCount = 0
    var resolvePersistenceServiceReturn = PersistenceServiceMockSpy()
    func resolvePersistenceService() -> PersistenceServing {
        resolvePersistenceServiceCallCount += 1
        return resolvePersistenceServiceReturn
    }
}
