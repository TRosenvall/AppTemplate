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
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(appTheme: AppTheme,
         moduleResolver: ModuleResolving) {
        self.appTheme = appTheme
        self.moduleResolver = moduleResolver
    }

    // MARK: - LaunchBuilding Functions
    func buildModule() async throws -> LaunchView {
        // Get needed properties
        let launchTheme = LaunchTheme(base: appTheme)

        // Build module parts
        let view = await LaunchViewController(theme: launchTheme)
        let presenter = LaunchPresenter(viewController: view)
        let animator = LaunchAnimator(viewController: view,
                                      output: presenter)
        let entityController = try await EntityController<LaunchVariables>()
        let interactor = LaunchInteractor(entityController: entityController,
                                          output: presenter)
        let router = LaunchRouter(presentingView: view,
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
