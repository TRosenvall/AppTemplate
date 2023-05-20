//
//  Entity.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/9/23.
//

import Foundation

///------

protocol Model: Codable {
    associatedtype ModelUtility: Codable

    var utility: ModelUtility { get set }
    var storedData: [String: StoredData] { get set }
    var encryptedData: [String: EncryptedData] { get set }
}

///------

enum EntityCodingKeys: CodingKey { case utility, storedData, encryptedData }
class Entity<ModelUtility: Utility>: Model {
    
    // MARK: - Properties
    typealias ModelUtility = ModelUtility

    var utility: ModelUtility
    var storedData: [String : StoredData]
    var encryptedData: [String : EncryptedData]

    // MARK: - Initializers
    init(utility: ModelUtility) {
        self.utility = utility
        self.storedData = [:]
        self.encryptedData = [:]
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
