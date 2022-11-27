//
//  ServiceContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

// If the service can be turned on and off (like the networking service or the
// encryption service), this states are loaded when the app is launched.
// Haptics
// Authentication
// Networking
// Encryption
// Persistence
protocol Service {}

protocol ServiceBuilding {

    /// Will define the type of service being built.
    associatedtype ServiceType

    /// Builds and returns the service
    func buildService() -> ServiceType
}
