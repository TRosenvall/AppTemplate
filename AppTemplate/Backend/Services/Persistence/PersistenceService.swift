//
//  PersistenceService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class PersistenceService: PersistenceServing {
    
    // MARK: - Properties
    var requiredServices: [UtilityType.Service] = [.Networking]
    
    var entityController: (any ModelControlling)?
    
    // MARK: - Initializers
    init() async throws {
        self.entityController = try await EntityController<PersistenceVariables>()
    }
    
    // MARK: - PersistenceServing Functions
    func save(_ entityData: Data?, for utility: Utility) async throws {
        try locallySave(entityData, for: utility)
        let entityController = self.entityController as? EntityController<PersistenceVariables>
        if let isCloudBackupEnabled: Bool = try await entityController?.retrieveData(for: .isCloudBackupEnabled),
           isCloudBackupEnabled {
            try self.cloudSave(entityData, for: utility)
        }
    }

    ///Attempt to retrieve models from device. If none are found, push new or empty model instead.
    internal func locallyLoad(_ utility: Utility) throws -> Data? {
        var fileURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
        fileURL.appendPathComponent(Constants.appShortName)
        fileURL.appendPathComponent("\(utility).json")
        return try? Data(contentsOf: fileURL)
    }

    internal func locallySave(_ data: Data?, for utility: Utility) throws {
        var fileURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
        fileURL.appendPathComponent(Constants.appShortName)
        fileURL.appendPathComponent("\(utility).json")
        try? data?.write(to: fileURL)
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
