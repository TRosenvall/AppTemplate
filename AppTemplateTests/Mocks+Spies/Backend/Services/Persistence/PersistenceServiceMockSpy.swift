//
//  PersistenceServiceMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class PersistenceServiceMockSpy: PersistenceServing {
    var locallySaveCallCount = 0
    var locallySaveArg: Model?
    func locallySave(_entity: Model) {
        locallySaveCallCount += 1
        locallySaveArg = _entity
    }

    var cloudSaveCallCount = 0
    var cloudSaveArg: Model?
    func cloudSave(_entity: Model) {
        cloudSaveCallCount += 1
        cloudSaveArg = _entity
    }

    var locallyLoadCallCount = 0
    var locallyLoadArg: Model?
    func locallyLoad(_entity: Model) {
        locallyLoadCallCount += 0
        locallyLoadArg = _entity
    }

    var cloudLoadCallCount = 0
    var cloudLoadArg: Model?
    func cloudLoad(_entity: Model) {
        cloudLoadCallCount += 1
        cloudLoadArg = _entity
    }
}
