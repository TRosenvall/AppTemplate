//
//  HomeAnimator.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/29/22.
//

import UIKit

class HomeAnimator: HomeAnimating {

    // MARK: - Properties
    let viewController: any HomeView
    let output: HomeOutput

    // MARK: - Initializers
    init(viewController: any HomeView,
         output: HomeOutput) {
        self.viewController = viewController
        self.output = output
    }

    // MARK: - HomeAnimating Functions

    // MARK: - Helper Functions

}
