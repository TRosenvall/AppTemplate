//
//  CodingVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum CodingVariables: ServiceVariable {
    case serviceState
}

extension CodingVariables {

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
        return .Coding
    }

    static var loadPriority: Int {
        return 3
    }
}

///------

