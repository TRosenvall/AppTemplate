//
//  HomeBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeBuilder: HomeBuilding {

    // MARK: - Properties

    let theme: HomeTheme

    // MARK: - Initializers
    init(theme: HomeTheme) {
        self.theme = theme
    }

    // MARK: - HomeBuilding Functions
    func buildModule() -> any HomeView {
        // Build module parts
        let view = HomeViewController(theme: theme)
        let presenter = HomePresenter(viewController: view)
        let animator = HomeAnimator(viewController: view,
                                    output: presenter)

        /// Can be configured immediately
        let entityController = EntityController<HomeVariables>()
        let interactor = HomeInteractor(entityController: entityController,
                                        output: presenter)
        let router = HomeRouter(presentingView: view)

        // Set the missing parts where needed
        presenter.animator = animator
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter

        // Return the view
        return view
    }

    // MARK: - Helper Functions
}
