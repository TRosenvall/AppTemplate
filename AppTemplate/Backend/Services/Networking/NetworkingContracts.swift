//
//  NetworkingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

protocol NetworkingBuilding: ServiceBuilding {}

protocol NetworkingServing: Service {

    /// If the networking service is off, no network calls will be made into or out of the app.
    var isOn: Bool { get set }

    /// Toggles the state of the service from off to on and vice versa.
    func toggleState()
}
