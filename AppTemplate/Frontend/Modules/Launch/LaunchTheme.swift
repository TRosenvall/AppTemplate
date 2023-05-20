//
//  LaunchTheme.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchTheme: ModuleTheme {
    typealias Controller = LaunchViewController
    weak var viewController: Controller?

    // MARK: - Properties
    let viewBackgroundColor: UIColor?

    // MARK: - Initializers
    init(base: AppTheme,
         viewBackgroundColor: UIColor? = nil) {
        self.viewBackgroundColor = viewBackgroundColor ?? base.colors.viewBackgroundColor
    }

    // MARK: - Module Theme Functions
    func apply() {
    }

    // MARK: - Helper Functions
}
