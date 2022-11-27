//
//  HomeConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class HomeConstraints: HomeConstraining {

    // MARK: - Properties
    var theme: HomeTheme
    var viewController: HomeView

    // MARK: - Constraints

    // MARK: - Initializers
    init(theme: HomeTheme,
         view: HomeView) {
        self.theme = theme
        self.viewController = view
    }

    // MARK: - HomeConstraining Functions
    func build() {
        // Get root view for view controller
        let rootView = viewController.view

        // Get all interactibles for the view controller
        let interactibles = getInteractibles()

        // Create remaining Views

        // Constrain Views

        // Format Views
        viewController.navigationItem.leftBarButtonItem = interactibles.settingsBarButtonItem
        viewController.navigationItem.rightBarButtonItem = interactibles.placeholderBarButtonItem
        rootView?.backgroundColor = theme.viewBackgroundColor
    }

    // MARK: - Helper Functions
    private func getInteractibles() -> (settingsBarButtonItem: UIBarButtonItem,
                                        placeholderBarButtonItem: UIBarButtonItem) {
        let settingsBarButtonItem = viewController.settingsBarButtonItem
        let placeholderBarButtonItem = viewController.placeholderBarButtonItem
        return (settingsBarButtonItem: settingsBarButtonItem,
                placeholderBarButtonItem: placeholderBarButtonItem)
    }
}
