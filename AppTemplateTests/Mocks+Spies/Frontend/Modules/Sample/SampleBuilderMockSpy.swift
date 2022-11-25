//
//  SampleBuilderMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate
import UIKit

class SampleBuilderMockSpy: SampleBuilding {

    var buildModuleCallCount = 0
    var buildModuleReturn: Module = SampleViewControllerMockSpy()
    func buildModule() -> Module {
        buildModuleCallCount += 1
        return buildModuleReturn
    }

}
