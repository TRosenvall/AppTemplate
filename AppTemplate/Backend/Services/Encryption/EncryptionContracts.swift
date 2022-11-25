//
//  EncryptionContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

protocol EncryptionBuilding: ServiceBuilding {}

protocol EncryptionServing: Service {

    /// If the networking service is off, no network calls will be made into or out of the app.
    var isOn: Bool { get set }

    /// Toggles the state of the service from off to on and vice versa.
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
    func toggleState()

    func encrypt()

    func decrypt()
}
