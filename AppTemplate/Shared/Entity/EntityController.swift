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

    /// Updates the entity at the `ModelVariable` with the new value
    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws

    /// Gets the value from the entity`
    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T?

    /// Gets and returns the whole entity in the controller
    func get() async -> any Model

    /// Sets the entity in the controller.
    func set(entity: any Model) async
}

///------

actor EntityController<VariableSet: Variable>: ModelControlling {

    // MARK: - Properties
    typealias ModelVariables = VariableSet

    var entity: any Model

    // MARK: - Initializers
    init() async throws {
        self.entity = Entity(utility: ModelVariables.utility)
        do {
            /// Try retrieve and set model
            if let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
                self.entity = try await dataRoutingService.loadDataFromDisk(for: ModelVariables.utility)
            }
        } catch {
            for variable in ModelVariables.allCases {
                try await updateModel(variable: variable, withValue: variable.defaultValue)
            }
        }
    }

    // MARK: - ServiceResolvingBroadcaster Functions

    // MARK: - ModelControlling Functions
    func get() -> any Model {
        return self.entity
    }

    func set(entity: any Model) {
        self.entity = entity
    }

    //DtM
    func updateModel(variable: ModelVariables,
                     withValue value: Encodable?) async throws {
        if let dataRoutingService: DataRoutingService = await getService(ofType: .DataRouting) {
            self.entity = try await dataRoutingService.updateEntityData(for: variable,
                                                                        with: value,
                                                                        on: ModelVariables.utility)
        }
    }

    //MtD
    func retrieveData<T: Decodable>(for variable: ModelVariables) async throws -> T? {
        let dataRoutingService: DataRoutingService? = await getService(ofType: .DataRouting)
        let value: T? = try await dataRoutingService?.retrieveValue(for: variable, from: entity)
        return value
    }

    // MARK: - Helper Functions
}

extension EntityController {

    // Nonisolated protocol conformance for `ServicesRequiring` for actor type
    nonisolated var requiredServices: [UtilityType.Service] {
        return [.DataRouting]
    }

    nonisolated var accessibleServices: [UtilityType.Service : any Service] {
        get async {
            var dictionary: [UtilityType.Service : Service] = [:]
            await requiredServices.asyncForEach { serviceType in
                if let service = await ServiceResolver.shared.resolveService(ofType: serviceType) {
                    dictionary.updateValue(service, forKey: serviceType)
                }
            }
            return dictionary
        }
    }
}

///------
