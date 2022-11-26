//
//  LaunchPresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchPresenter: LaunchPresenting, LaunchOutput {

    // MARK: - Properties
    var view: LaunchView
    var router: LaunchWireframe? = nil
    var interactor: LaunchInput? = nil

    // MARK: - Initializers
    init(view: LaunchView) {
        self.view = view
    }

    // MARK: - LaunchPresenting Functions
    func viewDidAppear() {
        router?.routeToHomeModule()
    }

    // MARK: - LaunchOutput Functions

    // MARK: - Helper Functions
}
