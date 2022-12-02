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
    let serviceResolver: ServiceResolving
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(appTheme: AppTheme,
         serviceResolver: ServiceResolving,
         moduleResolver: ModuleResolving) {
        self.appTheme = appTheme
        self.serviceResolver = serviceResolver
        self.moduleResolver = moduleResolver
    }

    // MARK: - HomeBuilding Functions
    func buildModule() -> HomeView {
        // Get needed properties
        let homeTheme = HomeTheme(base: appTheme)
        let persistenceService = serviceResolver.services.persistence

        // Build module parts
        let entity = HomeEntity(persistenceService: persistenceService)
        let view = HomeViewController(theme: homeTheme)
        let presenter = HomePresenter(viewController: view)
        let animator = HomeAnimator(viewController: view,
                                    output: presenter)
        let interactor = HomeInteractor(entity: entity,
                                          output: presenter)
        let router = HomeRouter(presentingView: view,
                                  moduleResolver: moduleResolver)

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
