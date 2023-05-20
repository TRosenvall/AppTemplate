//
//  HomeRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeRouter: HomeWireframe {

    // MARK: - Properties
    let presentingView: any Module

    // MARK: - Initializers
    init(presentingView: any Module) {
        self.presentingView = presentingView
    }

    // MARK: - HomeWireframe Functions
    func routeToSettingsModule() throws {
        Task {
            await ModuleResolver.shared.resolveModule(ofType: .Settings)
        }
    }

    // MARK: - Helper Functions
}
