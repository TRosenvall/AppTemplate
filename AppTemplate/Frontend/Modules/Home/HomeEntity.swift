//
//  HomeEntity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeEntity: HomeModel {

    // MARK: - Properties
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - HomeModel Functions

    // MARK: - Helper Functions
}
