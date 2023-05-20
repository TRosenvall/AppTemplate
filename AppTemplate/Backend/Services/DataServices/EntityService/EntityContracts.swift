//
//  EntityContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 5/17/23.
//

import Foundation

///------ Variable: Each Module and Service contains a Variable Set used to define storable data.

protocol Variable: CaseIterable {
    associatedtype ModelUtility: Utility
    
    // Variable Properties
    // The default value for any stored data should the values be reset
    var defaultValue: Encodable? { get }
    // Defines whether or not the data needs to be encrypted on storage
    var isEncryptable: Bool { get }
    // Defines whether or not the data should be persisted on the device
    var isPersistable: Bool { get }
    // Defines the amount of time after which a value should be returned to the default value.
    var resetsAfter: TimeInterval? { get }
    // The utility associated with a particular variable set.
    static var utility: ModelUtility { get }
}

extension Variable {
    // Will return the name of the variable.
    var label: String {
        let mirror = Mirror(reflecting: self)
        if let label = mirror.children.first?.label {
            return label
        } else {
            return String(describing:self)
        }
    }
}

///------ Entity Controller: Facilitates the storage and retrieval of data from an entity

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

///------ Entity Resolving: Facilitates the instantiation of entities

protocol EntityResolving {

    func resolveEntity<T: Utility>(ofType: T) -> Entity<T>?

}

///------ Entity Managing: Holds on to entities and dismisses them when available.

protocol EntityManaging {

    var entities: [any ModelControlling] { get }

}

///------ Entity Serving: The service that permits entity resolving and management.

protocol EntityServing {

    var resolver: EntityResolving { get }
    var manager: EntityManaging { get }

    func populateEntities()

    func
}
