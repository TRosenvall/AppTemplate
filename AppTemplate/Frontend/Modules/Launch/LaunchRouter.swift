//
//  LaunchRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchRouter: LaunchWireframe {

    // MARK: - Properties
    let presentingView: UIViewController
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(presentingView: UIViewController,
         moduleResolver: ModuleResolving) {
        self.presentingView = presentingView
        self.moduleResolver = moduleResolver
    }

    // MARK: - LaunchWireframe Functions

    // MARK: - Helper Functions
}
