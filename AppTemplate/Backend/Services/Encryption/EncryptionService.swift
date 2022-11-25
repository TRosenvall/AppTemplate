//
//  EncryptionService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

class EncryptionService: EncryptionServing {

    // MARK: - Properties
    let persistenceService: PersistenceServing

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - PersistenceServing Functions
    func start() {
        // TODO
    }

    func stop() {
        // TODO
    }

    func encrypt() {
        // TODO
    }
    
    func decrypt() {
        // TODO
    }

    // MARK: - Helper Functions
}
