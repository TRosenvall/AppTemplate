//
//  ModuleContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

protocol Module: UIViewController {}

protocol Constraining {

    /// Builds out the views of the view controller
    func build()
}

protocol ModuleBuilding {

    /// Will define the type of service being built.
    associatedtype ModuleType

    /// Builds and returns the module's viewController
    func buildModule() -> ModuleType
}

protocol Entity {}
