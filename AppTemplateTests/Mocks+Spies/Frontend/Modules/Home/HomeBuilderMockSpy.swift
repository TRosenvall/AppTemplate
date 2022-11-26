//
//  HomeBuilderMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate
import UIKit

class HomeBuilderMockSpy: HomeBuilding {
    typealias ModuleType = HomeView

    var buildModuleCallCount = 0
    var buildModuleReturn: HomeView = HomeViewControllerMockSpy()
    func buildModule() -> HomeView {
        buildModuleCallCount += 1
        return buildModuleReturn
    }

}
