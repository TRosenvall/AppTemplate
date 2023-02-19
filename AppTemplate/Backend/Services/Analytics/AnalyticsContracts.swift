//
//  AnalyticsContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/18/23.
//

import Foundation

///------

protocol AnalyticsServing: Service where VariableSet == AnalyticsVariables {
    func log(message: String, date: Date)
}

/// Default Implementation
extension AnalyticsServing {
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

protocol CanLogErrors: ServicesRequiring {
    /// Logs the error on the analytics service and then returns the error logged.
    func logError() -> Error
}

extension CanLogErrors {
    func logError() -> Error {
        Task {
            let analyticsService: AnalyticsService? = await getService(ofType: .Analytics)
            analyticsService?.log(message: "\(self)", date: Date())
        }
        return self as! Error
    }
}

///------
