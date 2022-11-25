//
//  PersistenceBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import Foundation

class PersistenceBuilder: PersistenceBuilding {

    // MARK: - Properties
    typealias ServiceType = PersistenceServing
    let networkingService: NetworkingServing

    // MARK: - Initializers
    init(networkingService: NetworkingServing) {
        self.networkingService = networkingService
    }

    // MARK: - NetworkingBuilding Functions
    func buildService() -> PersistenceServing {
        PersistenceService(networkingService: networkingService)
    }

    // MARK: - Helper Functions
}
