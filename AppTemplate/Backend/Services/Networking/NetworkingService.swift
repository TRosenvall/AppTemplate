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
    init() {}

    func buildEntity(from resolver: ServiceResolver) throws {
        Task {
            self.entityController = try await EntityController<NetworkingVariables>(resolver: resolver)
        }
    }

    // MARK: - NetworkingServing Functions

    // MARK: - NetworkingModelController Functions
    func toggleState() {

    }

    // MARK: - Helper Functions
}
