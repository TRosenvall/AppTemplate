//
//  EncryptionServiceMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/26/22.
//

@testable import AppTemplate

class EncryptionServiceMockSpy: EncryptionServing {
    var isOn: Bool = false

    var toggleStateCallCount = 0
    func toggleState() {
        toggleStateCallCount += 1
    }

    var encryptCallCount = 0
    func encrypt() {
        encryptCallCount += 1
    }

    var decryptCallCount = 0
    func decrypt() {
        decryptCallCount += 1
    }
}
