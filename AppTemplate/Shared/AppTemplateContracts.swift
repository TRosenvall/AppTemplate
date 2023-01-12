//
//  AppTemplateContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/4/22.
//

import Foundation

///------

protocol Variable: CaseIterable {
    associatedtype ModelUtility: Utility
    
    // Variable Properties
    var defaultValue: Encodable? { get }
    var isEncryptable: Bool { get }
    static var utility: ModelUtility { get }
}

extension Variable {
    // Will return the name of the variable.
    var label: String {
        let mirror = Mirror(reflecting: self)
        if let label = mirror.children.first?.label {
            return label
        } else {
            return String(describing:self)
        }
    }
}

///------

protocol Utility: Codable {}

///------
