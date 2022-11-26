//
//  HomeInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeInteractor: HomeInput {

    // MARK: - Properties
    let entity: HomeModel
    let output: HomeOutput

    // MARK: - Initializers
    init(entity: HomeModel,
         output: HomeOutput) {
        self.entity = entity
        self.output = output
    }

    // MARK: - HomeInput Functions

    // MARK: - Helper Functions
}
