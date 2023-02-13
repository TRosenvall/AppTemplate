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
        print("400. Configuring entity")
        do {
            /// Try retrieve and set model
            print("401. Attempting to get dataRoutingService and load data for \(ModelVariables.utility)")
            if let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
                print("402. Loading \(ModelVariables.utility)")
                self.entity = try await dataRoutingService.loadData(for: ModelVariables.utility)
            }
        } catch {
            print("403. Building new entity")
            self.entity = Entity(utility: ModelVariables.utility)
            for variable in ModelVariables.allCases {
                print("====----====----====----====")
                print("404. Updating model for variable: \(variable)")
                try await updateModel(variable: variable, withValue: variable.defaultValue)
            }
        }
    }

    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws {
        print("1000. Updating model for variable \(variable) with value \(String(describing: value))")
        print("1001. Getting dataRoutingService.")
        if let entity = self.entity,
           let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
            print("1002. Updating entity data")
            self.entity = try await dataRoutingService.updateEntityData(for: variable,
                                                                        with: value,
                                                                        on: entity)
            print("1003. Entity Stored Data")
            print(self.entity?.storedData)
            print("1004. Entity Encrypted Data")
            print(self.entity?.encryptedData)
        }
    }

    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T? {
        print("1400. Retrieving entity variable: \(variable)")
        guard let entity else {
            print("1401. Entity not initialized yet. Throwing error")
            throw "Entity not configured, unable to retrieve data"
        }
        print("1402. Getting dataRoutingService")
        let dataRoutingService: DataRoutingService? = await getService(ofType: .DataRouting)
        print("1403. Retrieving value for \(variable) on \(entity)")
        let value: T? = try await dataRoutingService?.retrieveValue(for: variable, from: entity)
        print("1404. Returning \(String(describing: value))")
        return value
    }

    // MARK: - Helper Functions
}

///------
