//
//  LaunchContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

/// This module is exists to act as a buffer between the main app and the app opening. Any necessary functions
/// for the app to run properly can be loaded in hear. Also, it let's us have a much more robust splash screen :)
protocol LaunchBuilding: ModuleBuilding {}

protocol LaunchView: Module {}

protocol LaunchPresenting {

    ///Runs at the end of the LaunchView `viewDidLoad()`. The Launch module will route immediately to the
    ///Sample Module.
    func viewDidAppear()
}

protocol LaunchInput {}

protocol LaunchModel: Entity {}

protocol LaunchOutput {}

protocol LaunchWireframe {

    ///Resolves the `SampleModule` and routes to it.
    func routeToSampleModule()
}
