//
//  ModuleResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

// Unlike services, which all sit in the back doing their thing, we want to load these only as needed.
protocol ModuleResolving {
    func resolveSampleModule() -> SampleView
}

class ModuleResolver: ModuleResolving {

    // MARK: - Properties
    let serviceResolver: ServiceResolving
    let appTheme: AppTheme

    var activeModule: Module? = nil

    // MARK: - Initializers
    init(appTheme: AppTheme,
         serviceResolver: ServiceResolving) {
        self.appTheme = appTheme
        self.serviceResolver = serviceResolver
    }

    // MARK: - ModuleResolving Functions
    func resolveLaunchModule() -> LaunchView {
        let launchBuilder = LaunchBuilder(appTheme: appTheme,
                                          serviceResolver: serviceResolver,
                                          moduleResolver: self)
        let launchModule = launchBuilder.buildModule()
        activeModule = launchModule
        return launchModule
    }

    func resolveSettingsModule() -> SettingsView {
        let settingsBuilder = SettingsBuilder(appTheme: appTheme,
                                              serviceResolver: serviceResolver,
                                              moduleResolver: self)
        let settingsModule = settingsBuilder.buildModule()
        activeModule = settingsModule
        return settingsModule
    }

    func resolveSampleModule() -> SampleView {
        let sampleBuilder = SampleBuilder(appTheme: appTheme,
                                          serviceResolver: serviceResolver,
                                          moduleResolver: self)
        let sampleModule = sampleBuilder.buildModule()
        activeModule = sampleModule
        return sampleModule
    }

    // MARK: - Helper Functions
}
