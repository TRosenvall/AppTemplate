//
//  LaunchPresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchPresenter: LaunchPresenting, LaunchOutput {

    // MARK: - Properties
    var viewController: any LaunchView
    var animator: LaunchAnimating?
    var router: LaunchWireframe?
    var interactor: LaunchInput?

    // MARK: - Initializers
    init(viewController: any LaunchView) {
        self.viewController = viewController
    }

    // MARK: - LaunchPresenting Functions
    func viewDidAppear() {
        Task {
            self.interactor?.launch()
            await viewController.activityIndicator?.animateViewDidAppear { didFinishLoading in
                if didFinishLoading {
                    do {
                        try self.router?.routeToHomeModule()
                    } catch {
                        // TODO: - Error Handling
                    }
                }
            }
        }
    }

    // MARK: - LaunchOutput Functions
    func didFinishLoading() {
        Task {
            await viewController.activityIndicator?.setDidFinishLoading(to: true)
        }
    }

    // MARK: - Helper Functions
}
