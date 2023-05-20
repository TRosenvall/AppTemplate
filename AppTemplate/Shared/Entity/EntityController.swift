//
//  EntityController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/9/23.
//

import Foundation

///------

protocol ModelControlling: Actor, ServicesRequiring {
    /// Will define the type of model being saved.
    associatedtype ModelVariables: Variable

    var entity: (any Model)? { get set }

    /// Updates the entity at the `ModelVariable` with the new value
    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws

    /// Gets the value from the entity`
    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T?

    /// Gets and sets the entity
    func configure(fromBackup: Bool) async throws
}

/// Default implementation
extension ModelControlling {
    func configure(fromBackup: Bool = false) async throws {
        try await configure(fromBackup: fromBackup)
    }
}

///------

actor EntityController<VariableSet: Variable>: ModelControlling {

    // MARK: - Properties
    typealias ModelVariables = VariableSet

    var entity: (any Model)?

    // MARK: - Initializers
    init() {}

    // MARK: - ModelControlling Functions
    func configure(fromBackup: Bool) async throws {
        do {
            /// Try retrieve and set model
            if let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
                self.entity = try await dataRoutingService.loadData(for: ModelVariables.utility)
            }
        } catch {
            self.entity = Entity(utility: ModelVariables.utility)
            for variable in ModelVariables.allCases {
                try await updateModel(variable: variable, withValue: variable.defaultValue)
            }
        }
    }

    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws {
        if let entity = self.entity,
           let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
            self.entity = try await dataRoutingService.updateEntityData(for: variable,
                                                                        with: value,
                                                                        on: entity)
        }
    }

    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T? {
        guard let entity else {
            throw AppErrors.Shared.EntityNotConfigured.logError()
        }
        let dataRoutingService: DataRoutingService? = await getService(ofType: .DataRouting)
        let value: T? = try await dataRoutingService?.retrieveValue(for: variable, from: entity)
        return value
    }

    // MARK: - Helper Functions
}

///------
