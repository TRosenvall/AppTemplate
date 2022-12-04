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

    // MARK: - SettingsBuilding Functions
    func buildModule() -> SettingsView {
        // Get needed properties
        let settingsTheme = SettingsTheme(base: appTheme)
        let persistenceService = serviceResolver.services.persistence

        // Build module parts
        let entity = SettingsEntity()
        let view = SettingsViewController(theme: settingsTheme)
        let presenter = SettingsPresenter(viewController: view)
        let animator = SettingsAnimator(viewController: view,
                                        output: presenter)
        let interactor = SettingsInteractor(persistenceService: persistenceService,
                                            entity: entity,
                                            output: presenter)
        let router = SettingsRouter(presentingView: view,
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
