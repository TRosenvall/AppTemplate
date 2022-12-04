//
//  NetworkingService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class NetworkingService: NetworkingServing {

    // MARK: - Properties
    let entity: NetworkingEntity

    // MARK: - Initializers
    init(entity: NetworkingEntity) {
        self.entity = entity
    }

    // MARK: - PersistenceServing Functions
    func toggleState() {
        isOn = !isOn
    }

    // MARK: - Helper Functions
}
