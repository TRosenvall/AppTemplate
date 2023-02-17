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
        print("1100. Updating entity")
        // Setvices
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        print("1101. Retrieved persistenceService: \(persistenceService != nil)")
        let codingService: CodingService? = await getService(ofType: .Coding)
        print("1102. Retrieved codingService: \(codingService != nil)")
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)
        print("1103. Retrieved encryptionService: \(encryptionService != nil)")

        // Create mutable entity from the existing entity
        var entity = entity

        // Ensure we have a value, otherwise remove it from the entity
        guard let value else {
            print("1104. Value is nil, removing value from entity")
            entity.storedData.removeValue(forKey: variable.label)
            entity.encryptedData.removeValue(forKey: variable.label)
            return entity
        }
        print("1105. Value: \(value)")

        
        // Get the data for a value or throw an error
        let valueData = try codingService?.encode(value)
        print("1106. Encoded value into valueData: \(String(describing: valueData))")

        // Encrypt and store data if variable is encryptable and encryption service is on.
        print("1107. Checking if the value can be encrypted.")
        do {
            let isEnabled = try await encryptionService?.isEncryptionEnabled == true
            let isEncryptable = variable.isEncryptable
            let isEncryptionAvailable = isEncryptable && isEncryptable
            print("1107.25. utility: \(T.utility)")
            print("1107.5. isEnabled: \(isEnabled)")
            print("1107.75. isEncryptable: \(isEncryptable)")
            if isEncryptionAvailable {
                print("1112.5. Encryption available")
                print("1504.5. Will retrieving symmetric key for utility: \(T.utility)")
                if let symmetricKey = try encryptionService?.getSymmetricKey(for: T.utility),
                   let encryptedData = try encryptionService?.encrypt(valueData, withKey: symmetricKey) {
                    print("1108. Value is encrypted, encryption service is enabled")
                    print("1109. Utility: \(utility), SymmetricKey: \(symmetricKey), ")
                    print("1110. EncryptedData: \(encryptedData)")
                    entity.encryptedData.updateValue(encryptedData, forKey: variable.label)
                    print("1111. Updated entity with encrypted value")
                }
            } else {
                print("1112. Encryption off and unneeded, throwing error to run catch block.")
                throw "Encryption unused"
            }
        } catch {
            print("1112. Unable to encrypt data")
            let storedData = StoredData(value: valueData)
            entity.storedData.updateValue(storedData, forKey: variable.label)
            print("1113. Updated entity with value")
        }

        // Persist the new entity
        print("1114. Persisting entity")
        let entityData = try codingService?.encode(entity)
        try await persistenceService?.save(entityData, for: T.utility)
        print("1115. Persistence finished")

        // Return it to be set on the model.
        print("1116. Entity Stored Data")
        print(entity.storedData)
        print("1117. Entity Encrypted Data")
        print(entity.encryptedData)

        return entity
    }

    /// Used to get a value from the entity
    func retrieveValue<T, R>(for variable: T,
                             from entity: (any Model)) async throws -> R? where T : Variable, R : Decodable {
        print("1500. Retrieving value")
        // Setvices
        let codingService: CodingService? = await getService(ofType: .Coding)
        print("1501. Retrieved codingService: \(codingService != nil)")
        let encryptionService: EncryptionService? = await getService(ofType: .Encryption)
        print("1502. Retrieved encryptionService: \(encryptionService != nil)")

        // Create an empty data value
        var data: Data?
        print("1503. Getting empty data value to be returned")

        // If the variable is decryptable, set the data to it's decrypted state
        print("1504. Checking if decryption is available and necessary.")
        print("1504.5. Will retrieving symmetric key for utility: \(entity.utility)")
        if variable.isEncryptable &&
           entity.encryptedData[variable.label] != nil,
           let utility = entity.utility as? Utility,
           let symmetricKey = try encryptionService?.getSymmetricKey(for: utility),
           let encryptedData = entity.encryptedData[variable.label] {
            print("1505. Decrypting Data")
            data = try encryptionService?.decrypt(encryptedData, withKey: symmetricKey)
        } else {
            print("1506. Retrieving stored data")
            // Otherwise retrieve the decrypted value
            data = entity.storedData[variable.label]?.value
        }

        // Decode and return the decrypted data.
        print("1507. Decoding and returning data.")
        do {
            return try codingService?.decode(data: data)
        } catch {
            print("1508. Unable to decode value, returning default value.")
            return variable.defaultValue as? R
        }
    }

    /// Used to get model data. The var `fromBackup` will always be false unless the user has initiated otherwise.
    func loadData<T: Utility>(for utility: T, fromBackup: Bool = false) async throws -> (any Model)? {
        // Setvices
        print("700. Getting persistence and coding services.")
        let persistenceService: PersistenceService? = await getService(ofType: .Persistence)
        print("701. Retrieved persistenceService \(persistenceService != nil)")
        let codingService: CodingService? = await getService(ofType: .Coding)
        print("702. Retrieved codingService \(codingService != nil)")

        // Load
        print("703. Load from cloud backup: \(fromBackup)")
        let data = fromBackup ? try persistenceService?.cloudLoad(utility) : try persistenceService?.locallyLoad(utility)
        print("704. Retrieved data: \(String(describing: data)), decoding data.")
        guard let entity: Entity<T> = try codingService?.decode(data: data)
        else {
            print("705. Unable to retrieve entity")
            throw "Unable to retrieve entity" }
        print("706. Retrieved entity for: \(entity.utility)")
        return entity
    }

    // MARK: - Helper Functions
}
