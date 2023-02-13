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
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - EncryptionServing Functions
    func getSymmetricKey(for utility: Utility) throws -> SymmetricKey? {
        print("2000. Retrieving symmetricKey")
        guard let data = "\(utility)".data(using: .utf8) else {
            print("2001. Unable to retrieve symmetricKey")
            throw "Unable to retrieve data for symmetricKey"
        }
        print("2001. SymmetricKey retrieved successfully.")
        return retrieveSymmetricKey(with: data)
    }

    func decrypt(_ encryptedData: EncryptedData?, withKey key: SymmetricKey?) throws -> Data {
        print("2200. Decrypting Data")
        guard let key = key,
              let nonceData = encryptedData?.nonce,
              let cipherText = encryptedData?.cipherText,
              let tag = encryptedData?.tag
        else {
            print("2201. Unable to unwrap key and datas.")
            throw "Unable to verify encrypted data and key."
        }
        print("2202. Successfully unwrapped key and data values.")
        print("2203. Key: \(key), nonceData: \(nonceData), cipherText: \(cipherText), tag: \(tag)")
        let nonce = try AES.GCM.Nonce(data: nonceData)
        let sealedBox = try AES.GCM.SealedBox(nonce: nonce,
                                              ciphertext: cipherText,
                                              tag: tag)
        print("2204. Successfully recreated sealed box.")
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    func encrypt(_ data: Data?, withKey key: SymmetricKey?) throws -> EncryptedData {
        print("2100. Encrypting Data")
        guard let data = data,
              let key = key
        else {
            print("2101. Unable to unwrap data and key")
            throw "No data or key"
        }
        print("2102. Key: \(key), Data: \(data)")
        let sealedBox = try AES.GCM.seal(data, using: key)
        print("2103. Successfully encrypted data with key.")
        print("2104. Sealed Box: \(sealedBox)")
        return EncryptedData(nonce: sealedBox.nonce.data,
                             cipherText: sealedBox.ciphertext,
                             tag: sealedBox.tag)
    }

    // MARK: - Helper Functions
    private func retrieveSymmetricKey(with utilityData: Data) -> SymmetricKey {
        let encodedData = utilityData.base64EncodedData()
        let hash = SHA256.hash(data: encodedData)
        let symmetricKeyData = hash.data
        let subData = symmetricKeyData.subdata(in: 0..<32)
        return SymmetricKey(data: subData)
    }
}
