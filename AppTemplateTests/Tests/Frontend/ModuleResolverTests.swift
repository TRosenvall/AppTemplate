//
//  ModuleResolverTests.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import XCTest
@testable import AppTemplate

class ModuleResolverTests: XCTestCase {

    var testUtility: TestUtility!
    var instanceUnderTest: ModuleResolver!

    override func setUpWithError() throws {
        testUtility = TestUtility()
        instanceUnderTest = ModuleResolver(appTheme: testUtility.appTheme,
                                           serviceResolver: testUtility.serviceResolver)
    }

    func testResolveSampleModule_willReturnSampleView() {
        // Arrange

        // Act
        let view = instanceUnderTest.resolveHomeModule()

        // Assert
        XCTAssertTrue(view is HomeViewController)
    }
}
