//
//  DataRoutingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/24/22.
//

import Foundation

///------

protocol DataRoutingServing: Service {
    var persistenceService: PersistenceServing? { get set }
    var codingService: CodingServing? { get set }
    var encryptionService: EncryptionServing? { get set }

    // Used to get the data values needed to be persisted. Uses the CodingService, EncryptionService, and PersistenceService
    func updateEntityData<T: Variable, R: Utility>(for variable: T,
                                                   with value: Encodable?,
                                                   on utility: R) async throws -> any Model

    // Used to retrieve data from an entity. Uses the CodingService and EncryptionService
    func retrieveValue<T: Variable, R: Decodable>(for variable: T,
                                                  from entity: any Model) async throws -> R?

    // Called from modelControllers to load entity data from disk. Uses PersistenceService
    func loadDataFromDisk<T: Utility>(for utility: T) throws -> any Model
}

///------
