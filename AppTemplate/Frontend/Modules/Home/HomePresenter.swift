//
//  HomePresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomePresenter: HomePresenting, HomeOutput {

    // MARK: - Properties
    var viewController: any HomeView
    var animator: HomeAnimating? = nil
    var router: HomeWireframe? = nil
    var interactor: HomeInput? = nil

    // MARK: - Initializers
    init(viewController: any HomeView) {
        self.viewController = viewController
    }

    // MARK: - HomePresenting Functions
    func settingsButtonTapped() {
        do {
            try router?.routeToSettingsModule()
        } catch {
            //TODO: - Error Handling
        }
    }

    // MARK: - HomeOutput Functions

    // MARK: - Helper Functions
}
