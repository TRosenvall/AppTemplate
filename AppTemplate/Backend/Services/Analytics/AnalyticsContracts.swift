//
//  AnalyticsContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/18/23.
//

import Foundation

///TODO:
/// - Swizzling UIControl to log user interactions
/// - Overload the _swift_willThrow handler in order to eliminate the need for the canLogErrors protocol - (Requires swift 5.8 included in xcode 14.3) https://stackoverflow.com/questions/75490214/is-it-possible-to-swizzle-the-keyword-throw/75496498#75496498
///

///------

protocol AnalyticsServing: Service where VariableSet == AnalyticsVariables {
    func log(message: String, in function: String, date: Date)
}

/// Default Implementation
extension AnalyticsServing {
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

protocol CanLogErrors: ServicesRequiring {
    /// Logs the error on the analytics service and then returns the error logged.
    func logError(in function: String) -> Error
}

extension CanLogErrors {
    func logError(in function: String = #function) -> Error {
        Task {
            let analyticsService: AnalyticsService? = await getService(ofType: .Analytics)
            analyticsService?.log(message: "\(self)", in: function, date: Date())
        }
        return self as! Error
    }
}

///------
