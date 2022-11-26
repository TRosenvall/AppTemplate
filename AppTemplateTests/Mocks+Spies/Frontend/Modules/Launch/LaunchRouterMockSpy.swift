//
//  LaunchRouterMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/26/22.
//

@testable import AppTemplate

class LaunchRouterMockSpy: LaunchWireframe {

    var routeToHomeModuleCallCount = 0
    func routeToHomeModule() {
        routeToHomeModuleCallCount += 1
    }
}
