//
//  Entity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/9/23.
//

import Foundation

///------ Entity Model

protocol Model: Codable {
    associatedtype ModelUtility: Codable

    var utility: ModelUtility { get set }
    var storedData: [String: DataStruct] { get set }
    var encryptedData: [String: EncryptedDataStruct] { get set }
}

///------ Entity

enum EntityCodingKeys: CodingKey { case utility, storedData, encryptedData }
class Entity<ModelUtility: Utility>: Model {
    
    // MARK: - Properties
    typealias ModelUtility = ModelUtility

    var utility: ModelUtility
    var storedData: [String : DataStruct]
    var encryptedData: [String : EncryptedDataStruct]
    var otherData: [String : DataStruct]

    // MARK: - Initializers
    init(utility: ModelUtility) {
        self.utility = utility
        self.storedData = [:]
        self.encryptedData = [:]
        self.otherData = [:]
    }

    // MARK: - ServiceModel Functions

    // MARK: - Codable Functions
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EntityCodingKeys.self)
        self.utility = try container.decode(ModelUtility.self, forKey: .utility)
        self.storedData = try container.decode([String: DataStruct].self, forKey: .storedData)
        self.encryptedData = try container.decode([String: EncryptedDataStruct].self, forKey: .encryptedData)
        self.otherData = [:]
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
