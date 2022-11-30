//
//  SettingsRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsRouter: SettingsWireframe {

    // MARK: - Properties
    let presentingView: UIViewController
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(presentingView: UIViewController,
         moduleResolver: ModuleResolving) {
        self.presentingView = presentingView
        self.moduleResolver = moduleResolver
    }

    // MARK: - SettingsWireframe Functions
    func routeBack() {
        presentingView.navigationController?.popToLeft()
    }

    // MARK: - Helper Functions
}
