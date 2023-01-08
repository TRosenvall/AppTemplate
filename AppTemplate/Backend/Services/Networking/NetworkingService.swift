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

    func buildEntity(delegate: ServiceResolvingDelegate, listener: ServiceDelegate?) throws {
        Task {
            self.entityController = try await EntityController<NetworkingVariables, UtilityType.Service>(delegate: delegate,
                                                                                                         listener: listener,
                                                                                                         utility: .Networking)
        }
    }

    // MARK: - NetworkingServing Functions

    // MARK: - NetworkingModelController Functions
    func toggleState() {

    }

    // MARK: - Helper Functions
}
