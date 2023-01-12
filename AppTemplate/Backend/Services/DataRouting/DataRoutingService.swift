//
//  DataRoutingService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/7/22.
//

import Foundation

// Functions needed here.

class DataRoutingService: DataRoutingServing {

    // MARK: - Properties
    var persistenceService: PersistenceServing?
    var codingService: CodingServing?
    var encryptionService: EncryptionServing?

    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {}

    func buildEntity(from resolver: ServiceResolver) throws {
        Task {
            self.entityController = try await EntityController<DataRoutingVariables>(resolver: resolver)
        }
    }

    // MARK: - DataRoutingServing Functions
    func updateEntityData<T, R>(for variable: T,
                                with value: Encodable?,
                                on utility: R) async throws -> any Model where T : Variable, R : Utility {
        let entity = Entity<R>(utility: utility)

        guard let value else {
            entity.storedData?.removeValue(forKey: variable.label)
            entity.encryptedData?.removeValue(forKey: variable.label)
            return entity
        }

        // Get the data for a value or throw an error
        let valueData = try codingService?.encode(value)

        // Store encrypted data if variable is encryptable and encryption service is on.
        if let encryptionEntity = encryptionService?.entityController as? EntityController<EncryptionVariables>,
           let encryptionServiceIsActive: Bool = try await encryptionEntity.retrieveData(for: .isActive),
           variable.isEncryptable && encryptionServiceIsActive,
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = try encryptionService?.encrypt(valueData, withKey: symmetricKey) {
            entity.encryptedData?.updateValue(encryptedData, forKey: variable.label)
        } else {
            let storedData = StoredData(value: valueData)
            entity.storedData?.updateValue(storedData, forKey: variable.label)
        }

        let entityData = try codingService?.encode(entity)
        try await persistenceService?.save(entityData, for: utility)

        return entity
    }

    func retrieveValue<T, R>(for variable: T,
                             from entity: any Model) async throws -> R? where T : Variable, R : Decodable {
        var data: Data?
        if let encryptionEntity = encryptionService?.entityController as? EntityController<EncryptionVariables>,
           let encryptionServiceIsActive: Bool = try await encryptionEntity.retrieveData(for: .isActive),
           encryptionServiceIsActive && variable.isEncryptable && entity.encryptedData?[variable.label] != nil,
           let utility = entity.utility as? Utility,
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = entity.encryptedData?[variable.label] {
            data = try encryptionService?.decrypt(encryptedData, withKey: symmetricKey)
        } else {
            data = entity.storedData?[variable.label]?.value
        }
        return try codingService?.decode(data: data)
    }

    func loadDataFromDisk<T: Utility>(for utility: T) throws -> any Model {
        let data = try persistenceService?.locallyLoad(utility)
        guard let entity: Entity<T> = try codingService?.decode(data: data)
        else { throw "Unable to retrieve entity" }
        return entity
    }

    // MARK: - Helper Functions
}
