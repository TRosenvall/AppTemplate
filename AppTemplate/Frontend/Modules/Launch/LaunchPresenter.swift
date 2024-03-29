//
//  LaunchPresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchPresenter: LaunchPresenting, LaunchOutput {

    // MARK: - Properties
    var viewController: LaunchView
    var animator: LaunchAnimating? = nil
    var router: LaunchWireframe? = nil
    var interactor: LaunchInput? = nil

    // MARK: - Initializers
    init(viewController: LaunchView) {
        self.viewController = viewController
    }

    // MARK: - LaunchPresenting Functions
    func viewDidAppear() {
        self.interactor?.launch()

        animator?.animateViewDidAppear() { didFinishLoading in
            if didFinishLoading {
                do {
                    try self.router?.routeToHomeModule()
                } catch {
                    // TODO: - Error Handling
                }
            }
        }
    }

    // MARK: - LaunchOutput Functions
    func didFinishLoading() {
        animator?.didFinishLoading = true
    }

    // MARK: - Helper Functions
}
