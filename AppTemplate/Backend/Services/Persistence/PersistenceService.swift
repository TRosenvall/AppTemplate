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
        print("1800. Saving data for utility \(utility)")
        try locallySave(entityData, for: utility)
        print("1801. Checking if entity should be backed up to cloud")
        let entityController = self.entityController as? EntityController<PersistenceVariables>
        if try await entityController?.retrieveData(for: .isCloudBackupEnabled) == true {
            print("1802. Backing up to cloud.")
            try self.cloudSave(entityData, for: utility)
        }
    }

    ///Attempt to retrieve models from device. If none are found, push new or empty model instead.
    internal func locallyLoad(_ utility: Utility) throws -> Data? {
        print("800. Locally loading \(utility)")
        var fileURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
        print("801. Root url: \(fileURL)")
        fileURL.appendPathComponent(Constants.appShortName)
        print("802. Root url with appName: \(fileURL)")
        fileURL.appendPathComponent("\(utility).json")
        print("803. Root url with utility: \(fileURL)")
        let data = try? Data(contentsOf: fileURL)
        print("804. Retrieved data: \(data != nil)")
        return data
    }

    internal func locallySave(_ data: Data?, for utility: Utility) throws {
        print("1700. Locally Saving")
        var fileURL = try FileManager.default.url(for: .applicationSupportDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
        print("1701. Root url: \(fileURL)")
        fileURL.appendPathComponent(Constants.appShortName)
        print("1702. Root url with utility: \(fileURL)")
        fileURL.appendPathComponent("\(utility).json")
        print("1703. Root url with utility: \(fileURL)")
        try? data?.write(to: fileURL)
        print("1704. Data written to disk")
    }
    
    internal func cloudSave(_ data: Data?, for utility: Utility) throws {
        print("1900. Backing up to cloud.")
        // TODO
    }
    
    internal func cloudLoad(_ utility: Utility) throws -> Data? {
        // TODO
        return Data()
    }

    // MARK: - PersistenceModelController Functions

    // MARK: - Helper Functions
}
