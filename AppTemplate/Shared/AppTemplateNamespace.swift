//
//  AppTemplateNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import Foundation

///------

public enum UtilityType {
    // Services
    enum Service: CaseIterable, Utility {
        case Persistence
        case Coding
        case Encryption
        case DataRouting
        case Networking
    }

    // Modules
    enum Module: CaseIterable, Utility {
        case Launch
        case Home
        case Settings
    }
}

///------

struct StoredData: Codable {
    let value: Data?
}

struct EncryptedData: Codable {
    var nonce: Data?
    var cipherText: Data?
    var tag: Data?
}

///------

enum EntityCodingKeys: CodingKey { case utility, storedData, encryptedData }
class Entity<ModelUtility: Utility>: Model, Codable {
    
    // MARK: - Properties
    typealias ModelUtility = ModelUtility

    var utility: ModelUtility
    var storedData: [String : StoredData]?
    var encryptedData: [String : EncryptedData]?

    // MARK: - Initializers
    init(utility: ModelUtility) {
        self.utility = utility
    }

    // MARK: - ServiceModel Functions

    // MARK: - Codable Functions
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EntityCodingKeys.self)
        self.utility = try container.decode(ModelUtility.self, forKey: .utility)
        self.storedData = try container.decode([String: StoredData].self, forKey: .storedData)
        self.encryptedData = try container.decode([String: EncryptedData].self, forKey: .encryptedData)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EntityCodingKeys.self)
        try container.encode(self.utility, forKey: .utility)
        try container.encode(self.storedData, forKey: .storedData)
        try container.encode(self.encryptedData, forKey: .encryptedData)
    }

    // MARK: - Helper Functions
}

///------

actor EntityController<VariableSet: Variable, ModelUtility: Utility>: ModelControlling {

    // MARK: - Properties
    typealias ModelVariables = VariableSet

    var entity: any Model
    var utilityType: ModelUtility
    var accessibleServices: [UtilityType.Service : Service]
    var delegate: ServiceResolvingDelegate?

    // MARK: - Initializers
    init(delegate: ServiceResolvingDelegate? = nil,
         listener: ServiceDelegate?,
         utility: ModelUtility) async throws {
        self.entity = Entity<ModelUtility>(utility: utility)
        self.utilityType = utility
        self.accessibleServices = [:]
        // This is a very hacky solution to the fact that only service utilities should have a delegate. This is an extra layer of protection, but I'd prefer a better solution.
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
            self.entity = try await dataRoutingService.updateEntityData(for: variable, withValue: value, on: utilityType)
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

extension String: Error {}
