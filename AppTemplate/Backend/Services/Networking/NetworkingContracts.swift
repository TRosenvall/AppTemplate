//
//  NetworkingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

///------

protocol NetworkingServing: Service where VariableSet == NetworkingVariables {}

/// Default Implementation
extension NetworkingServing {
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
