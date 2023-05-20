//
//  PersistenceService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class PersistenceService: PersistenceServing {

    // MARK: - Properties
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - PersistenceServing Functions
    func save(_ entityData: Data?, for utility: Utility) async throws {
        try locallySave(entityData, for: utility)
        let entityController = self.entityController as? EntityController<PersistenceVariables>
        if try await entityController?.retrieveData(for: .isCloudBackupEnabled) == true {
            try self.cloudSave(entityData, for: utility)
        }
    }

    ///Attempt to retrieve models from device. If none are found, push new or empty model instead.
    internal func locallyLoad(_ utility: Utility) throws -> Data? {
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appURL = appSupportURL.appendingPathComponent(K.appShortName)
        let fileURL = appURL.appendingPathComponent("\(utility).json")

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            throw AppErrors.Service.Persistence.UnableToRetrieveData.logError()
        }
    }

    internal func locallySave(_ data: Data?, for utility: Utility) throws {

        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory,
                                             in: .userDomainMask).first!
        try fileManager.createDirectory(at: appSupportURL,
                                        withIntermediateDirectories: true)

        let appURL = appSupportURL.appendingPathComponent(K.appShortName)
        try FileManager.default.createDirectory(at: appURL,
                                                withIntermediateDirectories: true)
        let fileURL = appURL.appendingPathComponent("\(utility).json")

        do {
            try data?.write(to: fileURL)
        } catch {
            throw AppErrors.Service.Persistence.UnableToWriteData.logError()
        }
    }
    
    internal func cloudSave(_ data: Data?, for utility: Utility) throws {
        // TODO
    }
    
    internal func cloudLoad(_ utility: Utility) throws -> Data? {
        // TODO
        return Data()
    }

    // MARK: - PersistenceModelController Functions

    // MARK: - Helper Functions
}
