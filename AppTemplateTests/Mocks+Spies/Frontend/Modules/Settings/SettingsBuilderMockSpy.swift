//
//  SettingsBuilderMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/26/22.
//

@testable import AppTemplate
import UIKit

class SettingsBuilderMockSpy: SettingsBuilding {
    typealias ModuleType = SettingsView

    var buildModuleCallCount = 0
    var buildModuleReturn = SettingsViewControllerMockSpy()
    func buildModule() -> SettingsView {
        buildModuleCallCount += 1
        return buildModuleReturn
    }
}
