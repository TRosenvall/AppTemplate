//
//  SettingsBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsBuilder: SettingsBuilding {

    // MARK: - Properties
    typealias ModuleType = SettingsView

    let appTheme: AppTheme
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(appTheme: AppTheme,
         moduleResolver: ModuleResolving) {
        self.appTheme = appTheme
        self.moduleResolver = moduleResolver
    }

    // MARK: - SettingsBuilding Functions
    func buildModule(listener: ServiceDelegate) async throws -> SettingsView {
        // Get needed properties
        let settingsTheme = SettingsTheme(base: appTheme)

        // Build module parts
        let view = await SettingsViewController(theme: settingsTheme)
        let presenter = SettingsPresenter(viewController: view)
        let animator = SettingsAnimator(viewController: view,
                                        output: presenter)
        let entityController = try await EntityController<SettingsVariables>(listener: listener)
        let interactor = SettingsInteractor(entityController: entityController,
                                            output: presenter)
        let router = SettingsRouter(presentingView: view,
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
