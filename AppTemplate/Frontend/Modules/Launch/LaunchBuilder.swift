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
        let presenter = LaunchPresenter(view: view)
        let interactor = LaunchInteractor(entity: entity,
                                          output: presenter as LaunchOutput)
        let router = LaunchRouter(presentingView: view,
                                  moduleResolver: moduleResolver)

        // Set the missing parts where needed
        presenter.interactor = interactor
        presenter.router = router

        // Return the view
        return view
    }

    // MARK: - Helper Functions
}
