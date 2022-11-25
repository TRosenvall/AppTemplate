//
//  SampleEntity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class SampleEntity: SampleModel {

    // MARK: - Properties
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - SampleModel Functions

    // MARK: - Helper Functions
}
