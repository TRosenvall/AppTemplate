//
//  LaunchBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchBuilder: LaunchBuilding {

    // MARK: - Properties
    typealias ModuleType = LaunchView

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

    // MARK: - LaunchBuilding Functions
    func buildModule() -> LaunchView {
        // Get needed properties
        let launchTheme = LaunchTheme(base: appTheme)
        let persistenceService = serviceResolver.services.persistence

        // Build module parts
        let entity = LaunchEntity(persistenceService: persistenceService)
        let view = LaunchViewController(theme: launchTheme)
        let presenter = LaunchPresenter(viewController: view)
        let animator = LaunchAnimator(viewController: view,
                                      output: presenter)
        let interactor = LaunchInteractor(entity: entity,
                                          output: presenter)
        let router = LaunchRouter(presentingView: view,
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
