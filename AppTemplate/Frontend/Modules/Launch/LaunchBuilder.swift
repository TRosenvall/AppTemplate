//
//  LaunchBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchBuilder: LaunchBuilding {

    // MARK: - Properties
    let theme: LaunchTheme

    // MARK: - Initializers
    init(theme: LaunchTheme) {
        self.theme = theme
    }

    // MARK: - LaunchBuilding Functions
    func buildModule() -> any LaunchView {
        // Build module parts
        let view = LaunchViewController(theme: theme)
        let presenter = LaunchPresenter(viewController: view)

        /// Needs to be configured after services load.
        let entityController = EntityController<LaunchVariables>()
        let interactor = LaunchInteractor(entityController: entityController,
                                          output: presenter)
        let router = LaunchRouter(presentingView: view)

        // Set the missing parts where needed
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter

        // Return the view
        return view
    }

    // MARK: - Helper Functions
}
