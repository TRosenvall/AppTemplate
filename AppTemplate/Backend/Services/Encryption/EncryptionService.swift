//
//  EncryptionService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation
import CryptoKit

class EncryptionService: EncryptionServing {

    // MARK: - Properties
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {}

    func buildEntity(from resolver: ServiceResolver) throws {
        Task {
            self.entityController = try await EntityController<EncryptionVariables>(resolver: resolver)
        }
    }

    // MARK: - EncryptionServing Functions
    func getSymmetricKey(for utility: Utility) throws -> SymmetricKey? {
        guard let data = "\(utility)".data(using: .utf8) else {
            throw "Unable to retrieve data for symmetricKey"
        }
        return retrieveSymmetricKey(with: data)
    }

    func decrypt(_ encryptedData: EncryptedData?, withKey key: SymmetricKey?) throws -> Data {
        guard let key = key,
              let nonceData = encryptedData?.nonce,
              let cipherText = encryptedData?.cipherText,
              let tag = encryptedData?.tag
        else {
            throw "Unable to verify encrypted data and key."
        }
        let nonce = try AES.GCM.Nonce(data: nonceData)
        let sealedBox = try AES.GCM.SealedBox(nonce: nonce,
                                              ciphertext: cipherText,
                                              tag: tag)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    func encrypt(_ data: Data?, withKey key: SymmetricKey?) throws -> EncryptedData {
        guard let data = data,
              let key = key
        else {
            throw "No data or key"
        }
        let sealedBox = try AES.GCM.seal(data, using: key)
        return EncryptedData(nonce: sealedBox.nonce.data,
                             cipherText: sealedBox.ciphertext,
                             tag: sealedBox.tag)
    }

    // MARK: - Helper Functions
    private func retrieveSymmetricKey(with utilityData: Data) -> SymmetricKey {
        let encodedData = utilityData.base64EncodedData()
        let hash = SHA256.hash(data: encodedData)
        let symmetricKeyData = hash.data
        return SymmetricKey(data: symmetricKeyData)
    }
}
