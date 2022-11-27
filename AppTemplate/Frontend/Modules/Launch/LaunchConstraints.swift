//
//  LaunchConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchConstraints: LaunchConstraining {

    // MARK: - Properties
    var theme: LaunchTheme
    var viewController: LaunchView

    // MARK: - Initializers
    init(theme: LaunchTheme,
         view: LaunchView) {
        self.theme = theme
        self.viewController = view
    }

    // MARK: - LaunchConstraining Functions

    // MARK: - Helper Functions
}
