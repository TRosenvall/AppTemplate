//
//  EncryptionBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

class EncryptionBuilder: EncryptionBuilding {

    // MARK: - Properties
    typealias ServiceType = EncryptionServing
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - NetworkingBuilding Functions
    func buildService() -> EncryptionServing {
        EncryptionService(persistenceService: persistenceService)
    }

    // MARK: - Helper Functions
}
