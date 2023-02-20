//
//  DataRoutingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/24/22.
//

import Foundation

///------

protocol DataRoutingServing: Service, ServicesRequiring where VariableSet == DataRoutingVariables {
    // Used to get the data values needed to be persisted. Uses the CodingService, EncryptionService, and PersistenceService
    func updateEntityData<T: Variable>(for variable: T,
                                       with value: Encodable?,
                                       on entity: (any Model)) async throws -> (any Model)?

    // Used to retrieve data from an entity. Uses the CodingService and EncryptionService
    func retrieveValue<T: Variable, R: Decodable>(for variable: T,
                                                  from entity: (any Model)) async throws -> R?

    // Called from modelControllers to load entity data. Uses PersistenceService
    func loadData<T: Utility>(for utility: T, fromBackup: Bool) async throws -> (any Model)?
}

/// Default Implementations
extension DataRoutingService {
    var state: Bool {
        get async throws {
            let entityController = entityController as? EntityController<VariableSet>
            guard let state: Bool = try await entityController?.retrieveData(for: .serviceState) else {
                throw AppErrors.Shared.EntityNotConfigured.logError()
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
