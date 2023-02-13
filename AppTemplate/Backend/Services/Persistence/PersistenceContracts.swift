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

protocol PersistenceServing: Service, ServicesRequiring where VariableSet == PersistenceVariables {
    
    /// Calls the save functions as needed.
    func save(_ entityData: Data?, for utility: Utility) async throws
    
    /// Locally saves the entity data
    func locallySave(_ data: Data?, for utility: Utility) throws
    
    /// Loads the local data when module is loaded, this will happen automatically.
    func locallyLoad(_ utility: Utility) throws -> Data?
    
    /// Saves entity data in cloud if enabled
    func cloudSave(_ data: Data?, for utility: Utility) throws
    
    /// Loads the cloud data if cloud saves are enabled and module is loaded, this must be called from the settings menu.
    func cloudLoad(_ utility: Utility) throws -> Data?
}

/// Default Implementations
extension PersistenceServing {
    var state: Bool {
        get async throws {
            let entityController = entityController as? EntityController<VariableSet>
            guard let state: Bool = try await entityController?.retrieveData(for: .serviceState) else {
                throw "Entity not configured"
            }
            return state
        }
    }

    func toggleState() async throws {
        let entityController = entityController as? EntityController<VariableSet>
        if let state: Bool = try await entityController?.retrieveData(for: .serviceState) {
            try await entityController?.updateModel(variable: .serviceState, withValue: !state)
        } else {
            let defaultState = VariableSet.serviceState.defaultValue as! Bool
            try await entityController?.updateModel(variable: .serviceState, withValue: defaultState)
        }
    }
}

///------
