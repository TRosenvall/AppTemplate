//
//  AppTheme.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class AppTheme {

    // MARK: - Properties
    let colors: Colors
    
    // MARK: - Component Subthemes
    lazy var activityIndicatorTheme = ActivityIndicatorTheme(base: self)
    lazy var tabBarTheme = TabBarTheme(base: self)
    lazy var navBarTheme = NavBarTheme(base: self)

    // MARK: - Module Subthemes
    lazy var launchTheme = LaunchTheme(base: self)
    lazy var homeTheme = HomeTheme(base: self)
    lazy var settingsTheme = SettingsTheme(base: self)
    

    // MARK: - Initializer
    init() {
        self.colors = Colors()
    }
}
