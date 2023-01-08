//
//  CodingNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

///------

enum CodingVariables: Variable {
    case isActive
}

extension CodingVariables {
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

