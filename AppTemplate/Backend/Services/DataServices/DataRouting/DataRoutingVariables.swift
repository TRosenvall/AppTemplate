//
//  DataRoutingVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum DataRoutingVariables: ServiceVariable {
    case serviceState
}

extension DataRoutingVariables {

    typealias ModelUtility = UtilityType.Service

    var defaultValue: Encodable? {
        switch self {
        case .serviceState: return true
        }
    }

    var isEncryptable: Bool {
        switch self {
        case .serviceState: return true
        }
    }

    static var utility: UtilityType.Service {
        return .DataRouting
    }

    static var loadPriority: Int {
        return 4
    }
}

///------
