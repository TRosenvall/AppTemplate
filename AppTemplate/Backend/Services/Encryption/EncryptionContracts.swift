//
//  EncryptionContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation
import CryptoKit

/// This service is responsible for encoding/decoding and encrypting/decrypting all data passing through the app.
/// If this service is toggled off, then any instance of this service should be set to nil and no data should be
/// able to be encrypted, though encoding, and decoding will still occur to facilitate regular app usage.

///------

extension SHA256.Digest {
    func serialize() -> String {
        return self.compactMap { String(format: "%02x", $0) }.joined()
    }

    var data: Data {
        return (self.serialize().data(using: .utf8)?.base64EncodedData())!
    }
}

extension AES.GCM.Nonce {
    func serialize() -> String {
        return self.withUnsafeBytes { body in
            Data(body).base64EncodedString()
        }
    }

    var data: Data {
        return self.withUnsafeBytes { body in
            Data(body)
        }
    }
}

///------

protocol EncryptionServing: Service {

    func decrypt(_ encryptedData: EncryptedData?, withKey key: SymmetricKey?) throws -> Data
    func encrypt(_ data: Data?, withKey key: SymmetricKey?) throws -> EncryptedData

    ///This key will be used to encrypt and decrypt all data pertaining to the app. When building an actual app
    ///using this template, this should be moved and made secure. Probably onto something related to a user and
    ///their authentication. Currently, it is one of the first peices of data loaded and loaded.

    ///This symmetricKey is used to encrypt and decrypt data. This key is not safe. When creating an actual app from this
    ///app template, this key needs to be created and tied to userData and persisted.
    func getSymmetricKey(for utility: Utility) throws -> SymmetricKey?

    /// Toggle On
    /// Checks all save data directories
    /// Pulls all app-owned .json files
    /// Encrypts the json files into .encr files
    /// Saves the encrypted files
    /// Removes the app-owned .json files
    /// Ensures all future saved data will be saved in an encrypted format
    
    /// Toggle Off
    /// Checks all save data directories
    /// Pulls all app-owned .encr files
    /// Decrypts the encr files into .json files
    /// Saves the decrypted files
    /// Removes the app-owned .encr files
    /// Ensures all future saved data will be saved in a decrypted format

}

///------
