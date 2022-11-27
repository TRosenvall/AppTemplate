//
//  SettingsContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

///Responsible for creating and assembling all the parts of the module.
protocol SettingsBuilding: ModuleBuilding {}

///Responsible for building out and setting up the views on the view controller.
protocol SettingsConstraining: Constraining {}

///Responsible for displaying information to and getting input from the user.
protocol SettingsView: Module {}

///Responsible for telling the view what to display and giving user input to the input file.
protocol SettingsPresenting {}

///Responsible for digesting user input and sending responses to the output.
protocol SettingsInput {}

///Responsible for handling anything that might need to be persisted for this module.
protocol SettingsModel: Entity {}

///Responsible for providing feedback to the user or telling the router to route away if necessary.
protocol SettingsOutput {}

///Responsible for navigating between the screens on the app as related to this module specifically.
protocol SettingsWireframe {}
