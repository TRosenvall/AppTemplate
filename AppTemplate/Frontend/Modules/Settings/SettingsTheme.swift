//
//  SettingsTheme.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsTheme: ModuleTheme {
    typealias Controller = SettingsViewController
    var viewController: Controller?

    // MARK: - Properties
    let viewBackgroundColor: UIColor?
    let navBarViewColor: UIColor?

    // MARK: - Initializers
    init(base: AppTheme,
         viewBackgroundColor: UIColor? = nil,
         navBarViewColor: UIColor? = nil) {
        self.viewBackgroundColor = viewBackgroundColor ?? base.colors.viewBackgroundColor
        self.navBarViewColor = navBarViewColor ?? base.colors.navBarViewColor
    }

    // MARK: - Module Theme Functions
    func apply() {
        // TODO
    }

    // MARK: - Helper Functions
}
