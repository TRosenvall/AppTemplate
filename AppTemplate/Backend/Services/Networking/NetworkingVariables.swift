//
//  NetworkingVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/19/22.
//

import Foundation

// TODO: - Update these as needed, these are data that will be saved, enums cannot conform to other protocols to extend their cases.
enum NetworkingVariables: ServiceVariable {
    case serviceState
}

extension NetworkingVariables {

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
        return .Networking
    }

    static var loadPriority: Int {
        return 5
    }
}
