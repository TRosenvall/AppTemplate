//
//  NetworkingVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

// TODO: - Update these as needed, these are data that will be saved, enums cannot conform to other protocols to extend their cases.
enum NetworkingVariables: Variable {
    case prop1
    case prop2
    case prop3
}

extension NetworkingVariables {

    typealias ModelUtility = UtilityType.Service

    var defaultValue: Encodable? {
        switch self {
        case .prop1: return nil
        case .prop2: return 5
        case .prop3: return "Hello World"
        }
    }

    var isEncryptable: Bool {
        switch self {
        case .prop1: return false
        case .prop2: return true
        case .prop3: return false
        }
    }

    static var utility: UtilityType.Service {
        return .Networking
    }
}
