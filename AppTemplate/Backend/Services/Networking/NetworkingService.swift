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
    init() async throws {
        self.entityController = try await EntityController<NetworkingVariables>()
    }

    // MARK: - NetworkingServing Functions

    // MARK: - NetworkingModelController Functions

    // MARK: - Helper Functions
}
