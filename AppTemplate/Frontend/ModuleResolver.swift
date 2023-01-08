//
//  ModuleResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

// Unlike services, which all sit in the back doing their thing, we want to load these only as needed.
protocol ModuleResolving {
    func resolveLaunchModule() async throws -> LaunchView
    func resolveSettingsModule() async throws -> SettingsView
    func resolveHomeModule() async throws -> HomeView
}

class ModuleResolver: ModuleResolving {

    // MARK: - Properties
    let appTheme: AppTheme

    var activeModule: Module? = nil

    var linkedToModules: [UtilityType.Module] = []

    // MARK: - Initializers
    init(appTheme: AppTheme) {
        self.appTheme = appTheme
    }

    // MARK: - ModuleResolving Functions
    func resolveLaunchModule() async throws -> LaunchView {
        let listener = ServiceResolver.shared
        let launchBuilder = LaunchBuilder(appTheme: appTheme,
                                          moduleResolver: self)
        let launchModule = try await launchBuilder.buildModule(listener: listener)
        activeModule = launchModule
        linkedToModules = [.Home]
        return launchModule
    }

    func resolveSettingsModule() async throws -> SettingsView {
        let listener = ServiceResolver.shared
        let settingsBuilder = SettingsBuilder(appTheme: appTheme,
                                              moduleResolver: self)
        let settingsModule = try await settingsBuilder.buildModule(listener: listener)
        activeModule = settingsModule
        linkedToModules = [.Home]
        return settingsModule
    }

    func resolveHomeModule() async throws -> HomeView {
        let listener = ServiceResolver.shared
        let homeBuilder = HomeBuilder(appTheme: appTheme,
                                          moduleResolver: self)
        let homeModule = try await homeBuilder.buildModule(listener: listener)
        activeModule = homeModule
        linkedToModules = [.Settings]
        return homeModule
    }

    // MARK: - Helper Functions
}
