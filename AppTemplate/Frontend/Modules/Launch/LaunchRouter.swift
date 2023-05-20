//
//  LaunchRouter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchRouter: LaunchWireframe {

    // MARK: - Properties
    let presentingView: any Module

    // MARK: - Initializers
    init(presentingView: any Module) {
        self.presentingView = presentingView
    }

    // MARK: - LaunchWireframe Functions
    func routeToHomeModule() throws {
        Task {
            let homeModule: Module = await ModuleResolver.shared.resolveModule(ofType: .Home,
                                                                               shouldPresent: true,
                                                                               shouldAnimateIfPresenting: true,
                                                                               navBarOption: .inheritNavBar,
                                                                               tabBarOption: .inheritTabBar,
                                                                               presentationStyle: nil)
        }
    }

    // MARK: - Helper Functions
}
