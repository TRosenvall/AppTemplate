//
//  NetworkingService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class NetworkingService: NetworkingServing {

    // MARK: - Properties
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - NetworkingServing Functions

    // MARK: - NetworkingModelController Functions

    // MARK: - Helper Functions
}
