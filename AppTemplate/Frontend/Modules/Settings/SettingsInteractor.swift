//
//  SettingsInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsInteractor: SettingsInput {

    // MARK: - Properties
    let entity: SettingsModel
    let output: SettingsOutput

    // MARK: - Initializers
    init(entity: SettingsModel,
         output: SettingsOutput) {
        self.entity = entity
        self.output = output
    }

    // MARK: - SettingsInput Functions

    // MARK: - Helper Functions
}
