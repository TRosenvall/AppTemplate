//
//  ModuleContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

protocol Module: UIViewController {
    func set(_ presenter: any ModulePresenting) async
}

///-------

protocol ModuleBuilding {

    /// Will define the type of service being built.
    associatedtype ModuleType

    /// Builds and returns the module's viewController
    func buildModule(listener: ServiceDelegate) async throws -> ModuleType
}

///------

protocol ModuleAnimating {}

///------

protocol ModulePresenting {}

///------

protocol ModuleInput {
    var entityController: any ModelControlling { get }
}

///------

protocol ModuleOutput {}

///------

protocol ModuleWireframe {}
