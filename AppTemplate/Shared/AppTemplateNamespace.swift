//
//  AppTemplateNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import Foundation

///------

public enum UtilityType {
    // Services
    enum Service: CaseIterable, Utility {
        case Persistence
        case Coding
        case Encryption
        case DataRouting
        case Networking
        case Analytics
    }

    // Modules
    enum Module: CaseIterable, Utility {
        case Launch
        case Home
        case Settings
    }
}

///------

struct StoredData: Codable {
    let value: Data?
}

struct EncryptedData: Codable {
    var nonce: Data?
    var cipherText: Data?
    var tag: Data?
}

///------

extension String: Error {}
