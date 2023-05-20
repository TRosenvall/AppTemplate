//
//  AppNamespace.swift
//  App
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import UIKit

///------ Constants: These are constants available throughout the app.

typealias K = Constants

enum Constants {
    static let screenSize = UIScreen.main.bounds
    static let appShortName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    static let transitionDuration: TimeInterval = 0.33
}

///------ Utility Type: This is an enum containing information about each service and module available
///                     within the app.

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

struct DataStruct: Codable {
    let value: Data?
}

struct EncryptedDataStruct: Codable {
    var nonce: Data?
    var cipherText: Data?
    var tag: Data?
}

///------
