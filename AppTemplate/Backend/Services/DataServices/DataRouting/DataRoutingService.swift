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
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - DataRoutingServing Functions
    /// Used to update the value on an entity.
    func updateEntityData<T>(for variable: T,
                             with value: Encodable?,
                             on entity: (any Model)) async throws -> (any Model)? where T : Variable {
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        let codingService: CodingService? = await getService(ofType: .Coding)
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)

        // Create mutable entity from the existing entity
        var entity = entity

        // Ensure we have a value, otherwise remove it from the entity
        guard let value else {
            entity.storedData.removeValue(forKey: variable.label)
            entity.encryptedData.removeValue(forKey: variable.label)
            return entity
        }

        // Get the data for a value or throw an error
        let valueData = try codingService?.encode(value)

        // Encrypt and store data if variable is encryptable and encryption service is on.
        do {
            let isEnabled = try await encryptionService?.isEncryptionEnabled == true
            let isEncryptable = variable.isEncryptable
            let isEncryptionAvailable = isEnabled && isEncryptable
            if isEncryptionAvailable {
                if let symmetricKey = try encryptionService?.getSymmetricKey(for: T.utility),
                   let encryptedData = try encryptionService?.encrypt(valueData, withKey: symmetricKey) {
                    entity.encryptedData.updateValue(encryptedData, forKey: variable.label)
                }
            } else {
                throw AppErrors.Service.DataRouting.EncryptionNotNeeded.logError()
            }
        } catch {
            let storedData = StoredData(value: valueData)
            entity.storedData.updateValue(storedData, forKey: variable.label)
        }

        // Persist the new entity
        let entityData = try codingService?.encode(entity)
        try await persistenceService?.save(entityData, for: T.utility)

        // Return it to be set on the model.
        return entity
    }

    /// Used to get a value from the entity
    func retrieveValue<T, R>(for variable: T,
                             from entity: (any Model)) async throws -> R? where T : Variable, R : Decodable {
        // Setvices
        let codingService: CodingService? = await getService(ofType: .Coding)
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)

        // Create an empty data value
        var data: Data?

        // If the variable is decryptable, set the data to it's decrypted state
        if variable.isEncryptable &&
           entity.encryptedData[variable.label] != nil,
           let utility = entity.utility as? Utility,
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = entity.encryptedData[variable.label] {
            data = try encryptionService?.decrypt(encryptedData, withKey: symmetricKey)
        } else {
            // Otherwise retrieve the decrypted value
            data = entity.storedData[variable.label]?.value
        }

        // Decode and return the decrypted data.
        do {
            return try codingService?.decode(data: data)
        } catch {
            return variable.defaultValue as? R
        }
    }

    /// Used to get model data. The var `fromBackup` will always be false unless the user has initiated otherwise.
    func loadData<T: Utility>(for utility: T, fromBackup: Bool = false) async throws -> (any Model)? {
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        let codingService: CodingService? = await getService(ofType: .Coding)

        // Load
        let data = fromBackup ? try persistenceService?.cloudLoad(utility) : try persistenceService?.locallyLoad(utility)
        guard let entity: Entity<T> = try codingService?.decode(data: data)
        else {
            throw AppErrors.Service.DataRouting.UnableToDecodeEntity.logError()
        }
        return entity
    }

    // MARK: - Helper Functions
}
