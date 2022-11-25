//
//  NetworkingBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

class NetworkingBuilder: NetworkingBuilding {

    // MARK: - Properties
    typealias ServiceType = NetworkingServing

    // MARK: - Initializers
    init() {}

    // MARK: - NetworkingBuilding Functions
    func buildService() -> NetworkingServing {
        NetworkingService()
    }

    // MARK: - Helper Functions
}
