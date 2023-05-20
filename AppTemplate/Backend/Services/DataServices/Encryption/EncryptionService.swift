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
        guard let data = "\(utility)".data(using: .utf8) else {
            throw AppErrors.Service.Encryption.UnableToRetrieveSymmetricKey.logError()
        }
        return retrieveSymmetricKey(with: data)
    }

    func decrypt(_ encryptedData: EncryptedData?, withKey key: SymmetricKey?) throws -> Data {
        var util: Utility?
        for serviceType in UtilityType.Service.allCases {
            if try getSymmetricKey(for: serviceType) == key {
                util = serviceType
            }
        }
        for moduleType in UtilityType.Module.allCases {
            if try getSymmetricKey(for: moduleType) == key {
                util = moduleType
            }
        }
        guard let key = key,
              let nonceData = encryptedData?.nonce,
              let cipherText = encryptedData?.cipherText,
              let tag = encryptedData?.tag
        else {
            throw AppErrors.Service.Encryption.UnableToVerifyDataAndKey.logError()
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
            throw AppErrors.Service.Encryption.UnableToVerifyDataAndKey.logError()
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
        let subData = symmetricKeyData.subdata(in: 0..<32)
        return SymmetricKey(data: subData)
    }
}
