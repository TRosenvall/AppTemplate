//
//  HomeRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeRouter: HomeWireframe {

    // MARK: - Properties
    let presentingView: UIViewController
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(presentingView: UIViewController,
         moduleResolver: ModuleResolving) {
        self.presentingView = presentingView
        self.moduleResolver = moduleResolver
    }

    // MARK: - HomeWireframe Functions
    func routeToSettingsModule() {
        let settingsModule = moduleResolver.resolveSettingsModule()
        presentingView.navigationController?.pushFromLeft(controller: settingsModule)
    }

    // MARK: - Helper Functions
}
