//
//  AnalyticsVariables.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/18/23.
//

import Foundation

///------

enum AnalyticsVariables: ServiceVariable {
    case serviceState
}

extension AnalyticsVariables {

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
        return .Analytics
    }

    static var loadPriority: Int {
        return 1
    }
}
