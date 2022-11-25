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
    var isOn: Bool = false

    // MARK: - Initializers
    init(persistenceService: PersistenceServing) {
        self.persistenceService = persistenceService
    }

    // MARK: - PersistenceServing Functions
    func toggleState() {
        // TODO
        isOn = !isOn
    }

    func encrypt() {
        // TODO
    }
    
    func decrypt() {
        // TODO
    }

    // MARK: - Helper Functions
}
