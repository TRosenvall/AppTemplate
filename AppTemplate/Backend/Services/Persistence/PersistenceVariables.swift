//
//  PersistenceVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum PersistenceVariables: ServiceVariable {
    case serviceState
    case isCloudBackupEnabled
}

extension PersistenceVariables {

    typealias ModelUtility = UtilityType.Service

    // Variable Properties
    var defaultValue: Encodable? {
        switch self {
        case .serviceState: return true
        case .isCloudBackupEnabled: return false
        }
    }

    var isEncryptable: Bool {
        switch self {
        case .serviceState: return true
        case .isCloudBackupEnabled: return true
        }
    }

    static var utility: UtilityType.Service {
        return .Persistence
    }

    static var loadPriority: Int {
        return 2
    }
}
