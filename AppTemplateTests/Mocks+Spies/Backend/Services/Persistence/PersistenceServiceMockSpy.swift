//
//  PersistenceServiceMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class PersistenceServiceMockSpy: PersistenceServing {
    var locallySaveCallCount = 0
    var locallySaveArg: Entity?
    func locallySave(_entity: Entity) {
        locallySaveCallCount += 1
        locallySaveArg = _entity
    }

    var cloudSaveCallCount = 0
    var cloudSaveArg: Entity?
    func cloudSave(_entity: Entity) {
        cloudSaveCallCount += 1
        cloudSaveArg = _entity
    }

    var locallyLoadCallCount = 0
    var locallyLoadArg: Entity?
    func locallyLoad(_entity: Entity) {
        locallyLoadCallCount += 0
        locallyLoadArg = _entity
    }

    var cloudLoadCallCount = 0
    var cloudLoadArg: Entity?
    func cloudLoad(_entity: Entity) {
        cloudLoadCallCount += 1
        cloudLoadArg = _entity
    }
}
