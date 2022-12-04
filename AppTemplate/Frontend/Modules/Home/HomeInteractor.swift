//
//  HomeInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class HomeInteractor: HomeInput, HomeModelController {

    // MARK: - Properties
    let persistenceService: PersistenceServing
    let entity: HomeModel
    let output: HomeOutput

    // MARK: - Initializers
    init(persistenceService: PersistenceServing,
         entity: HomeModel,
         output: HomeOutput) {
        self.persistenceService = persistenceService
        self.entity = entity
        self.output = output
    }

    // MARK: - HomeInput Functions

    // MARK: - HomeModelController Functions
    func save(entity: Entity) {}
    
    func load(entity: Entity) {}

    // MARK: - Helper Functions
}
