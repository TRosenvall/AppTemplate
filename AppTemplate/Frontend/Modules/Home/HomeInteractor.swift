//
//  HomeInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeInteractor: HomeInput {

    // MARK: - Properties
    let entityController: any ModelControlling
    let output: HomeOutput

    // MARK: - Initializers
    init(entityController: any ModelControlling,
         output: HomeOutput) {
        self.entityController = entityController
        self.output = output
    }

    // MARK: - HomeInput Functions

    // MARK: - HomeModelController Functions

    // MARK: - Helper Functions
}
