//
//  LaunchTheme.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchTheme {

    // MARK: - Properties
    let viewBackgroundColor: UIColor?

    // MARK: - Initializers
    init(base: AppTheme,
         viewBackgroundColor: UIColor? = nil) {
        self.viewBackgroundColor = viewBackgroundColor ?? base.colors.viewBackgroundColor
    }

    // MARK: - Helper Functions
}
