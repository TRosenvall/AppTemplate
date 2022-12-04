//
//  SettingsInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class SettingsInteractor: SettingsInput, SettingsModelController {
    

    // MARK: - Properties
    let persistenceService: PersistenceServing
    let entity: SettingsModel
    let output: SettingsOutput

    // MARK: - Initializers
    init(persistenceService: PersistenceServing,
         entity: SettingsModel,
         output: SettingsOutput) {
        self.persistenceService = persistenceService
        self.entity = entity
        self.output = output
    }

    // MARK: - SettingsInput Functions

    // MARK: - SettingsModelController Functions
    func save(entity: Entity) {}
    
    func load(entity: Entity) {}

    // MARK: - Helper Functions
}
