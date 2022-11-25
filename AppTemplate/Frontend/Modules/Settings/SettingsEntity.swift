//
//  SettingsEntity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsEntity: SettingsModel {

    // MARK: - Properties
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - SettingsModel Functions

    // MARK: - Helper Functions
}
