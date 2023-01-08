//
//  AppTemplateContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/4/22.
//

import Foundation

///------

protocol Variable: CaseIterable {
    // Variable Properties
    var defaultValue: Encodable? { get }
    var isEncryptable: Bool { get }
}

extension Variable {
    // Will give the name of the variable.
    var label: String {
        let mirror = Mirror(reflecting: self)
        if let label = mirror.children.first?.label {
            return label
        } else {
            return String(describing:self)
        }
    }
}

///------

protocol Utility: Codable {}

///------

protocol Model: Codable {
    associatedtype ModelUtility: Codable

    var utility: ModelUtility { get set }
    var storedData: [String: StoredData]? { get set }
    var encryptedData: [String: EncryptedData]? { get set }
}

///------
protocol ServiceDelegate {
    func subscribe(_ object: ServiceResolvingBroadcaster)
}

protocol ModelControlling: Actor, ServiceResolvingBroadcaster {
    /// Will define the type of model being saved.
    associatedtype ModelVariables: Variable

    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws
    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T?

    func get() async -> any Model
    func set(entity: any Model) async
    func buildModel() async throws
}

// Default Implementation
extension ModelControlling {
    nonisolated var requiredServices: [UtilityType.Service] {
        return [.DataRouting]
    }
}

///------

protocol ServiceResolvingBroadcaster {
    var requiredServices: [UtilityType.Service] { get }
    var accessibleServices: [UtilityType.Service: any Service] { get async }
    func updateDependencies(from serviceResolver: ServiceResolving?) async
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T?
}

// Default Implementation
extension ServiceResolvingBroadcaster {
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T? {
        return await accessibleServices[serviceType] as? T
    }
}
