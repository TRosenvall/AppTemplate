//
//  EncryptionContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

protocol EncryptionBuilding: ServiceBuilding {}

protocol EncryptionServing: Service {
    /// Start
    /// Checks all save data directories
    /// Pulls all app-owned .json files
    /// Encrypts the json files into .encr files
    /// Saves the encrypted files
    /// Removes the app-owned .json files
    /// Ensures all future saved data will be saved in an encrypted format
    func start()

    /// Stop
    /// Checks all save data directories
    /// Pulls all app-owned .encr files
    /// Decrypts the encr files into .json files
    /// Saves the decrypted files
    /// Removes the app-owned .encr files
    /// Ensures all future saved data will be saved in a decrypted format
    func stop()

    func encrypt()

    func decrypt()
}
