//
//  LaunchInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchInteractor: LaunchInput {

    // MARK: - Properties
    let entity: LaunchModel
    let output: LaunchOutput

    // MARK: - Initializers
    init(entity: LaunchModel,
         output: LaunchOutput) {
        self.entity = entity
        self.output = output
    }

    // MARK: - LaunchInput Functions
    func loadSettings() {
        Task {
            // Load services settings and other data as needed
            output.didFinishLoading()
        }
    }

    // MARK: - Helper Functions
}
