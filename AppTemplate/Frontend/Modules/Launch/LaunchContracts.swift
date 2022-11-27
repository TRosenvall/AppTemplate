//
//  LaunchContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

///This module is exists to act as a buffer between the main app and the app opening. Any necessary functions
///for the app to run properly can be loaded in hear. Also, it let's us have a much more robust splash screen :)
///Responsible for creating and assembling all the parts of the module.
protocol LaunchBuilding: ModuleBuilding {}

///Responsible for building out and setting up the views on the view controller.
protocol LaunchConstraining {}

///Responsible for displaying information to and getting input from the user.
protocol LaunchView: Module {}

///Responsible for telling the view what to display and giving user input to the input file.
protocol LaunchPresenting {

    ///Runs at the end of the LaunchView `viewDidLoad()`. The Launch module will route immediately to the
    ///Sample Module.
    func viewDidAppear()
}

///Responsible for digesting user input and sending responses to the output.
protocol LaunchInput {}

///Responsible for handling anything that might need to be persisted for this module.
protocol LaunchModel: Entity {}

///Responsible for providing feedback to the user or telling the router to route away if necessary.
protocol LaunchOutput {}

///Responsible for navigating between the screens on the app as related to this module specifically.
protocol LaunchWireframe {

    ///Resolves the `SampleModule` and routes to it.
    func routeToHomeModule()
}