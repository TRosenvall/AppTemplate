//
//  LaunchBuilderMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/26/22.
//

@testable import AppTemplate
import UIKit

class LaunchBuilderMockSpy: LaunchBuilding {

    typealias ModuleType = LaunchView

    var buildModuleCallCount = 0
    var buildModuleReturn = LaunchViewControllerMockSpy()
    func buildModule() -> LaunchView {
        buildModuleCallCount += 1
        return buildModuleReturn
    }
}
