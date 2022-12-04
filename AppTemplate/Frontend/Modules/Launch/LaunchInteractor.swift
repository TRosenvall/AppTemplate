//
//  LaunchInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchInteractor: LaunchInput, LaunchModelController {

    // MARK: - Properties
    let persistenceService: PersistenceServing
    let entity: LaunchModel
    let output: LaunchOutput

    // MARK: - Initializers
    init(persistenceService: PersistenceServing,
         entity: LaunchModel,
         output: LaunchOutput) {
        self.persistenceService = persistenceService
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

    // MARK: - LaunchModelController Functions
    func save(entity: Entity) {}
    
    func load(entity: Entity) {}

    // MARK: - Helper Functions
}
