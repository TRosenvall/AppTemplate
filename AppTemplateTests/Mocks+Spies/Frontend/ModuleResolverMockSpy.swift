//
//  ModuleResolverMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class ModuleResolverMockSpy: ModuleResolving {

    var resolveLaunchModuleCallCount = 0
    var resolveLaunchModuleReturn = LaunchViewControllerMockSpy()
    func resolveLaunchModule() -> LaunchView {
        resolveLaunchModuleCallCount += 1
        return resolveLaunchModuleReturn
    }

    var resolveSettingsModuleCallCount = 0
    var resolveSettingsModuleReturn = SettingsViewControllerMockSpy()
    func resolveSettingsModule() -> SettingsView {
        resolveSettingsModuleCallCount += 1
        return resolveSettingsModuleReturn
    }

    var resolveHomeModuleCallCount = 0
    var resolveHomeModuleReturn = HomeViewControllerMockSpy()
    func resolveHomeModule() -> HomeView {
        resolveHomeModuleCallCount += 1
        return resolveHomeModuleReturn
    }
}

