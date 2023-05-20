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

    // MARK: - Initializers
    init(presentingView: UIViewController) {
        self.presentingView = presentingView    }

    // MARK: - SettingsWireframe Functions
    func routeBack() {
        presentingView.navigationController?.popToLeft()
    }

    // MARK: - Helper Functions
}
