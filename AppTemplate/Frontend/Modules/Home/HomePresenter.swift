//
//  HomePresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomePresenter: HomePresenting, HomeOutput {
    
    // MARK: - Properties
    var view: HomeView
    var router: HomeWireframe? = nil
    var interactor: HomeInput? = nil

    // MARK: - Initializers
    init(view: HomeView) {
        self.view = view
    }

    // MARK: - HomePresenting Functions

    // MARK: - HomeOutput Functions

    // MARK: - Helper Functions
}
