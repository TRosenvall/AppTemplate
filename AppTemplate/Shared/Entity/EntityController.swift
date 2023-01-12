//
//  EntityController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/9/23.
//

import Foundation

///------

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

///------

actor EntityController<VariableSet: Variable>: ModelControlling {

    // MARK: - Properties
    typealias ModelVariables = VariableSet
    typealias ModelUtility = ModelVariables.ModelUtility

    var entity: any Model
    var accessibleServices: [UtilityType.Service : Service]
    var delegate: ServiceResolvingDelegate?

    // MARK: - Initializers
    // The service resolver is acting as both the delegate and listener here.
    init(resolver: ServiceResolver) async throws {
        try await self.init(delegate: resolver,
                            listener: resolver)
    }

    init(delegate: ServiceResolvingDelegate? = nil,
         listener: ServiceDelegate?) async throws {
        self.entity = Entity<ModelUtility>(utility: ModelVariables.utility)
        self.accessibleServices = [:]
        // This is a very hacky solution to the fact that only service utilities should have a delegate. This is an extra layer of protection, but I'd prefer a better solution.
        // The delegate doesn't belong here, I think it actually belongs on the service module.
        if ModelUtility.self is UtilityType.Service.Type {
            self.delegate = delegate
        }

        try await self.buildModel()
        await self.updateDependencies()

        listener?.subscribe(self)
    }

    // MARK: - ServiceResolvingBroadcaster Functions
    func updateDependencies(from serviceResolver: ServiceResolving? = nil) async {
        requiredServices.forEach { serviceType in
            if let service: Service = self.delegate?.resolveService(ofType: serviceType) {
                accessibleServices.updateValue(service, forKey: serviceType)
            }
        }
    }

    // MARK: - ModelControlling Functions
    func get() -> any Model {
        return self.entity
    }

    func set(entity: any Model) {
        self.entity = entity
    }

    func buildModel() async throws {
        for variable in ModelVariables.allCases {
            try await updateModel(variable: variable, withValue: variable.defaultValue)
        }
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

///------
