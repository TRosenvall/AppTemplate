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

        var appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        print("1701. Root url: \(appSupportURL)")

        var appURL = appSupportURL.appendingPathComponent(Constants.appShortName)
        print("1702. App url: \(appURL)")

        var fileURL = appURL.appendingPathComponent("\(utility).json")
        print("1703. file url: \(fileURL)")

        do {
            let data = try Data(contentsOf: fileURL)
            print("804. Retrieved data: \(data)")
            return data
        } catch {
            print("805. Unable to retrieve data from \(fileURL)")
            print("806. Error: \(error)")
            throw error
        }
    }

    internal func locallySave(_ data: Data?, for utility: Utility) throws {
        print("1700. Locally Saving")

        var appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try fileManager.createDirectory(at: appSupportURL,
                                        withIntermediateDirectories: true)
        print("1701. Root url: \(appSupportURL)")

        var appURL = appSupportURL.appendingPathComponent(Constants.appShortName)
        print("1701.5 Create directories at which to save the file if it doesn't exist.")
        try FileManager.default.createDirectory(at: appURL,
                                                withIntermediateDirectories: true)
        print("1702. App url: \(appURL)")

        var fileURL = appURL.appendingPathComponent("\(utility).json")
        print("1703. file url: \(fileURL)")

        do {
            try data?.write(to: fileURL)
            print("1704. Data written to disk")
        } catch {
            print("1705. Unable to write data to \(fileURL)")
            print("1706. Error: \(error)")
            throw error
        }
    }
    
    internal func cloudSave(_ data: Data?, for utility: Utility) throws {
        print("1900. Backing up to cloud.")
        print("1901. TODO")
        // TODO
    }
    
    internal func cloudLoad(_ utility: Utility) throws -> Data? {
        print("2300. Loading backup from cloud")
        print("2301. TODO")
        // TODO
        return Data()
    }

    // MARK: - PersistenceModelController Functions

    // MARK: - Helper Functions
}
