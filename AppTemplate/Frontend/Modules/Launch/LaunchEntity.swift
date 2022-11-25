//
//  LaunchEntity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchEntity: LaunchModel {

    // MARK: - Properties
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - LaunchModel Functions

    // MARK: - Helper Functions
}
