//
//  HomeConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class HomeConstraints: HomeConstraining {

    // MARK: - Properties
    var viewController: HomeView

    // MARK: - Initializers
    init(view: HomeView) {
        self.viewController = view
    }

    // MARK: - HomeConstraining Functions
    func setupViews() {
        viewController.view.backgroundColor = .blue
    }

    // MARK: - Helper Functions
}
