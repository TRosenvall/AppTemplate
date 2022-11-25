//
//  PersistenceContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

protocol PersistenceBuilding: ServiceBuilding {}

/// This service handles all of the saving and loading of entity data throughout the app.
protocol PersistenceServing: Service {

    // Locally saves the entity data
    func locallySave(_entity: Entity)

    // Saves entity data in cloud if enabled
    func cloudSave(_entity: Entity)

    // Loads the local data when module is loaded
    func locallyload(_entity: Entity)

    // Loads the cloud data if cloud saves are enabled and module is loaded.
    func cloudLoad(_entity: Entity)
}
