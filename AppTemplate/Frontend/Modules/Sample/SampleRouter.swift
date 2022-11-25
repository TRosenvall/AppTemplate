//
//  SampleRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class SampleRouter: SampleWireframe {

    // MARK: - Properties
    let presentingView: UIViewController
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(presentingView: UIViewController,
         moduleResolver: ModuleResolving) {
        self.presentingView = presentingView
        self.moduleResolver = moduleResolver
    }

    // MARK: - SampleWireframe Functions

    // MARK: - Helper Functions
}
