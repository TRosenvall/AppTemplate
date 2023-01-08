//
//  DataRoutingNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum DataRoutingVariables: Variable {
    case isActive
}

extension DataRoutingVariables {
    var defaultValue: Encodable? {
        switch self {
        case .isActive: return true
        }
    }

    var isEncryptable: Bool {
        switch self {
        case .isActive: return true
        }
    }
}

///------
