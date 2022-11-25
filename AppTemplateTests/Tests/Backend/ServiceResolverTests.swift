//
//  ServiceResolverTests.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import XCTest
@testable import AppTemplate

class ServiceResolverTests: XCTestCase {

    var testUtility: TestUtility!
    var instanceUnderTest: ServiceResolver!

    override func setUpWithError() throws {
        testUtility = TestUtility()
        instanceUnderTest = ServiceResolver()
    }

    func testResolveNetworkingService_willReturnNetworkingService() {
        // Arrange

        // Act
        let networkingService = instanceUnderTest.resolveNetworkingService()

        // Assert
        XCTAssertTrue(networkingService is NetworkingService)
    }

    func testResolvePersistenceService_willReturnPersistenceService() {
        // Arrange

        // Act
        let persistenceService = instanceUnderTest.resolvePersistenceService()

        // Assert
        XCTAssertTrue(persistenceService is PersistenceService)
    }
}
