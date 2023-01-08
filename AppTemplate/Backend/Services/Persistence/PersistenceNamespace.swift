//
//  PersistenceNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum PersistenceVariables: Variable {
    case isActive
    case isCloudBackupEnabled
}

extension PersistenceVariables {

    // Variable Properties
    var defaultValue: Encodable? {
        switch self {
        case .isActive: return true
        case .isCloudBackupEnabled: return false
        }
    }

    var isEncryptable: Bool {
        switch self {
        case .isActive: return true
        case .isCloudBackupEnabled: return true
        }
    }
}
