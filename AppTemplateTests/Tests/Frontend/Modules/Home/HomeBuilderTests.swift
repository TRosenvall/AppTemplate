//
//  HomeBuilderTests.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import XCTest
@testable import AppTemplate

class HomeBuilderTests: XCTestCase {

    var testUtility: TestUtility!
    var instanceUnderTest: HomeBuilder!

    override func setUpWithError() throws {
        testUtility = TestUtility()
        instanceUnderTest = HomeBuilder(appTheme: testUtility.appTheme,
                                          serviceResolver: testUtility.serviceResolver,
                                          moduleResolver: testUtility.moduleResolver)
    }

    func testBuildModule_resolvesHomeView() {
        // Arrange

        // Act
        let homeModule = instanceUnderTest.buildModule()

        // Assert
        XCTAssertTrue(homeModule is HomeViewController)
    }
}
