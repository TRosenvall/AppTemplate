//
//  PersistenceService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class PersistenceService: PersistenceServing {

    // MARK: - Properties
    let networkingService: NetworkingServing
    let encryptionService: EncryptionServing? = nil

    // MARK: - Initializers
    init(networkingService: NetworkingServing) {
        self.networkingService = networkingService
    }

    // MARK: - PersistenceServing Functions
    func locallySave(_entity: Entity) {
        // TODO
    }

    func cloudSave(_entity: Entity) {
        // TODO
    }

    func locallyload(_entity: Entity) {
        // TODO
    }

    func cloudLoad(_entity: Entity) {
        // TODO
    }

    // MARK: - Helper Functions
}
