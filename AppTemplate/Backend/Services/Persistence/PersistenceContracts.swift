//
//  PersistenceContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

/// This service handles all of the saving and loading of entity data throughout the app.
/// If this service is toggled off, then any instance of this service should be set to nil everywhere and no saving
/// should be able to occur anywhere, though locally loading will still occur to facilitate regular app usage. By
/// default, this service cannot be toggled off.

///------

protocol PersistenceServing: Service, ServicesRequiring {

    func save(_ entityData: Data?, for utility: Utility) async throws

    // Locally saves the entity data
    func locallySave(_ data: Data?, for utility: Utility) throws

    // Loads the local data when module is loaded, this will happen automatically.
    func locallyLoad(_ utility: Utility) throws -> Data?

    // Saves entity data in cloud if enabled
    func cloudSave(_ data: Data?, for utility: Utility) throws

    // Loads the cloud data if cloud saves are enabled and module is loaded, this must be called from the settings menu.
    func cloudLoad(_ utility: Utility) throws -> Data?
}

///------
