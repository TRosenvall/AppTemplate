//
//  TestUtility.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation
@testable import AppTemplate

class TestUtility {

    // MARK: - Resolvers
    lazy var serviceResolver = ServiceResolverMockSpy()
    lazy var moduleResolver = ModuleResolverMockSpy()

    // MARK: - Themes
    lazy var appTheme = AppTheme()
    lazy var launchTheme = LaunchTheme(base: appTheme)
    lazy var settingsTheme = SettingsTheme(base: appTheme)
    lazy var homeTheme = HomeTheme(base: appTheme)

    // MARK: - Initializer
    init() {}
}
