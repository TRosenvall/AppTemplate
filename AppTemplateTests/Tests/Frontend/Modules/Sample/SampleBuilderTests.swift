//
//  SampleBuilderTests.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import XCTest
@testable import AppTemplate

class SampleBuilderTests: XCTestCase {

    var testUtility: TestUtility!
    var instanceUnderTest: SampleBuilder!

    override func setUpWithError() throws {
        testUtility = TestUtility()
        instanceUnderTest = SampleBuilder(appTheme: testUtility.appTheme,
                                          serviceResolver: testUtility.serviceResolver,
                                          moduleResolver: testUtility.moduleResolver)
    }

    func testBuildModule_resolvesSampleView() {
        // Arrange

        // Act
        let sampleModule = instanceUnderTest.buildModule()

        // Assert
        XCTAssertTrue(sampleModule is SampleViewController)
    }
}
