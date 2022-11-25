//
//  ModuleResolverMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class ModuleResolverMockSpy: ModuleResolving {

    var resolveSampleModuleCallCount = 0
    var resolveSampleModuleReturn = SampleViewControllerMockSpy() as Module
    func resolveSampleModule() -> Module {
        resolveSampleModuleCallCount += 1
        return resolveSampleModuleReturn
    }
}

