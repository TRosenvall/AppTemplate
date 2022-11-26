//
//  NetworkingServiceMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class NetworkingServiceMockSpy: NetworkingServing {
    var isOn: Bool = false

    var toggleStateCallCount = 0
    func toggleState() {
        toggleStateCallCount += 1
    }
}
