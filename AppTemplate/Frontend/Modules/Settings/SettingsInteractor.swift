//
//  SettingsInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsInteractor: SettingsInput {
    

    // MARK: - Properties
    let entityController: any ModelControlling
    let output: SettingsOutput

    // MARK: - Initializers
    init(entityController: any ModelControlling,
         output: SettingsOutput) {
        self.entityController = entityController
        self.output = output
    }

    // MARK: - SettingsInput Functions

    // MARK: - SettingsModelController Functions

    // MARK: - Helper Functions
}
