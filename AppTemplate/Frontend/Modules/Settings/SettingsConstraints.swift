//
//  SettingsConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsConstraints: SettingsConstraining {

    // MARK: - Properties
    var theme: SettingsTheme
    var viewController: SettingsView

    // MARK: - Initializers
    init(theme: SettingsTheme,
         view: SettingsView) {
        self.theme = theme
        self.viewController = view
    }

    // MARK: - SettingsConstraining Functions
    func build() {
        // Get root view for view controller
        let rootView = viewController.view

        // Get all interactibles for the view controller
//        let interactibles = getInteractibles()

        // Create remaining Views

        // Constrain Views

        // Format Views
//        viewController.navigationItem.leftBarButtonItem = interactibles.settingsBarButtonItem
//        viewController.navigationItem.rightBarButtonItem = interactibles.placeholderBarButtonItem
        rootView?.backgroundColor = theme.viewBackgroundColor
    }

    // MARK: - Helper Functions
}
