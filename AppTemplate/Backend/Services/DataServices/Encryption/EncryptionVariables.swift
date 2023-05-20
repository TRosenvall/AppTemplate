//
//  EncryptionVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum EncryptionVariables: ServiceVariable {
    case serviceState
    case isEncryptionEnabled
}

extension EncryptionVariables {

    typealias ModelUtility = UtilityType.Service

    var defaultValue: Encodable? {
        switch self {
        case .serviceState: return true
        case .isEncryptionEnabled: return true
        }
    }

    // The encryption service CANNOT encrypt it's own variables.
    var isEncryptable: Bool {
        return false
    }

    static var utility: UtilityType.Service {
        return .Encryption
    }

    /// This entity must be loaded first.
    static var loadPriority: Int {
        return 0
    }
}

///------
