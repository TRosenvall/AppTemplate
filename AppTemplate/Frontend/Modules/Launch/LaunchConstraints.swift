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
         viewController: LaunchView) {
        self.theme = theme
        self.viewController = viewController
    }

    // MARK: - LaunchConstraining Functions
    func build() {}

    // MARK: - Helper Functions
}
