//
//  HomeBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeBuilder: HomeBuilding {

    // MARK: - Properties
    typealias ModuleType = HomeView

    let appTheme: AppTheme
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(appTheme: AppTheme,
         moduleResolver: ModuleResolving) {
        self.appTheme = appTheme
        self.moduleResolver = moduleResolver
    }

    // MARK: - HomeBuilding Functions
    func buildModule() async throws -> HomeView {
        // Get needed properties
        let homeTheme = HomeTheme(base: appTheme)

        // Build module parts
        let view = await HomeViewController(theme: homeTheme)
        let presenter = HomePresenter(viewController: view)
        let animator = HomeAnimator(viewController: view,
                                    output: presenter)
        let entityController = try await EntityController<HomeVariables>()
        let interactor = HomeInteractor(entityController: entityController,
                                        output: presenter)
        let router = HomeRouter(presentingView: view,
                                  moduleResolver: moduleResolver)

        // Set the missing parts where needed
        presenter.animator = animator
        presenter.interactor = interactor
        presenter.router = router
        await view.set(presenter)

        // Return the view
        return view
    }

    // MARK: - Helper Functions
}
