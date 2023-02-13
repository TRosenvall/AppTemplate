//
//  CodingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import Foundation

/// This service handles all of the encoding and decoding throughout the app.
/// If this service is toggled off, then any instance of this service should be set to nil everywhere and no saving
/// should be able to occur anywhere, though saving/loading of the core services remain activeto facilitate regular app
/// usage. By default, this service cannot be toggled off.

///------

protocol CodingServing: Service where VariableSet == CodingVariables {
    func encode<T: Encodable>(_ object: T) throws -> Data?
    func decode<T: Decodable>(data: Data?) throws -> T
}

/// Default Implementations
extension CodingServing {
    var encoder: JSONEncoder {
        return JSONEncoder()
    }
    var decoder: JSONDecoder {
        return JSONDecoder()
    }

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
