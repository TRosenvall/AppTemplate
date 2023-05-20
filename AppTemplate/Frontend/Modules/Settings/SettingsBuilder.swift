//
//  SettingsBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsBuilder: SettingsBuilding {
    // MARK: - Properties
    let theme: SettingsTheme

    // MARK: - Initializers
    init(theme: SettingsTheme) {
        self.theme = theme
    }

    // MARK: - SettingsBuilding Functions
    func buildModule() -> any SettingsView {
        // Build module parts
        let view = SettingsViewController(theme: theme)
        let presenter = SettingsPresenter(viewController: view)
        let animator = SettingsAnimator(viewController: view,
                                        output: presenter)
        let entityController = EntityController<SettingsVariables>()
        let interactor = SettingsInteractor(entityController: entityController,
                                            output: presenter)
        let router = SettingsRouter(presentingView: view)

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
