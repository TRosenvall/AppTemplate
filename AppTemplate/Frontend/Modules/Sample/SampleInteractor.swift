//
//  SampleInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class SampleInteractor: SampleInput {

    // MARK: - Properties
    let entity: SampleModel
    let output: SampleOutput

    // MARK: - Initializers
    init(entity: SampleModel,
         output: SampleOutput) {
        self.entity = entity
        self.output = output
    }

    // MARK: - SampleInput Functions

    // MARK: - Helper Functions
}
