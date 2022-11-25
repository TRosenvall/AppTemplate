//
//  SettingsPresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsPresenter: SettingsPresenting, SettingsOutput {
    
    // MARK: - Properties
    var view: SettingsView
    var router: SettingsWireframe? = nil
    var interactor: SettingsInput? = nil

    // MARK: - Initializers
    init(view: SettingsView) {
        self.view = view
    }

    // MARK: - SettingsPresenting Functions

    // MARK: - SettingsOutput Functions

    // MARK: - Helper Functions
}
