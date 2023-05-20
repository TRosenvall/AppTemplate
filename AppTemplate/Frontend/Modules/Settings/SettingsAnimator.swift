//
//  SettingsAnimator.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/29/22.
//

import UIKit

class SettingsAnimator: SettingsAnimating {

    // MARK: - Properties
    let viewController: any SettingsView
    let output: SettingsOutput

    // MARK: - Initializers
    init(viewController: any SettingsView,
         output: SettingsOutput) {
        self.viewController = viewController
        self.output = output
    }

    // MARK: - SettingsAnimating Functions

    // MARK: - Helper Functions

}
