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
    var requiredServices: [UtilityType.Service] = [.Persistence,
                                                   .Coding,
                                                   .Encryption]

    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() async throws {
        self.entityController = try await EntityController<DataRoutingVariables>()
    }

    // MARK: - DataRoutingServing Functions
    /// Used to update the value on an entity.
    func updateEntityData<T, R>(for variable: T,
                                with value: Encodable?,
                                on utility: R) async throws -> any Model where T : Variable, R : Utility {
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        let codingService: CodingService? = await getService(ofType: .Coding)
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)

        // Create new entity
        let entity = Entity<R>(utility: utility)

        // Ensure we have a value
        guard let value else {
            entity.storedData?.removeValue(forKey: variable.label)
            entity.encryptedData?.removeValue(forKey: variable.label)
            return entity
        }

        // Get the data for a value or throw an error
        let valueData = try codingService?.encode(value)

        // Encrypt and store data if variable is encryptable and encryption service is on.
        if try await isEncryptable(variable),
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = try encryptionService?.encrypt(valueData, withKey: symmetricKey) {
            entity.encryptedData?.updateValue(encryptedData, forKey: variable.label)
        } else {
            let storedData = StoredData(value: valueData)
            entity.storedData?.updateValue(storedData, forKey: variable.label)
        }

        // Persist the new entity
        let entityData = try codingService?.encode(entity)
        try await persistenceService?.save(entityData, for: utility)

        // Return it to be set on the model.
        return entity
    }

    /// Used to get a value from the entity
    func retrieveValue<T, R>(for variable: T,
                             from entity: any Model) async throws -> R? where T : Variable, R : Decodable {
        // Setvices
        let codingService: CodingService? = await getService(ofType: .Coding)
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)

        // Create an empty data value
        var data: Data?

        // If the variable is decryptable, set the data to it's decrypted state
        if try await isEncryptable(variable) &&
           entity.encryptedData?[variable.label] != nil,
           let utility = entity.utility as? Utility,
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = entity.encryptedData?[variable.label] {
            data = try encryptionService?.decrypt(encryptedData, withKey: symmetricKey)
        } else {
            // Otherwise retrieve the decrypted value
            data = entity.storedData?[variable.label]?.value
        }

        // Decode and return the decrypted data.
        return try codingService?.decode(data: data)
    }

    /// Used to get model data from the disk
    func loadDataFromDisk<T: Utility>(for utility: T) async throws -> any Model {
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        let codingService: CodingService? = await getService(ofType: .Coding)

        // Load
        let data = try persistenceService?.locallyLoad(utility)
        guard let entity: Entity<T> = try codingService?.decode(data: data)
        else { throw "Unable to retrieve entity" }
        return entity
    }

    /// Used to get model data from cloud store. This is used on a user-initiated command.
    func loadDataFromCloud<T: Utility>(for utility: T) async throws -> any Model {
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        let codingService: CodingService? = await getService(ofType: .Coding)

        let data = try persistenceService?.cloudLoad(utility)
        guard let entity: Entity<T> = try codingService?.decode(data: data)
        else { throw "Unable to retrieve entity" }
        return entity
    }

    // MARK: - Helper Functions
    func isEncryptable<T: Variable>(_ variable: T) async throws -> Bool {
        // Setvices
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)

        if let encryptionEntity = encryptionService?.entityController as? EntityController<EncryptionVariables>,
           let encryptionServiceIsActive: Bool = try await encryptionEntity.retrieveData(for: .isActive),
           variable.isEncryptable && encryptionServiceIsActive {
            return true
        }
        return false
    }
}
