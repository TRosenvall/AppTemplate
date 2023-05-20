//
//  SettingsPresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsPresenter: SettingsPresenting, SettingsOutput {

    // MARK: - Properties
    var viewController: any SettingsView
    var animator: SettingsAnimating? = nil
    var router: SettingsWireframe? = nil
    var interactor: SettingsInput? = nil

    // MARK: - Initializers
    init(viewController: any SettingsView) {
        self.viewController = viewController
    }

    // MARK: - SettingsPresenting Functions
    func backButtonTapped() {
        router?.routeBack()
    }

    // MARK: - SettingsOutput Functions

    // MARK: - Helper Functions
}
