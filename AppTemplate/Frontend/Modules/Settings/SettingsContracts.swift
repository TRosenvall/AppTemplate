//
//  SettingsContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

///Responsible for creating and assembling all the parts of the module.
protocol SettingsBuilding: ModuleBuilding {}

///Responsible for any animations pertaining to the Settings Module
protocol SettingsAnimating: ModuleAnimating {}

///Responsible for displaying information to and getting input from the user.
protocol SettingsView: Module {
    func backBarButtonItemTapped()

    func placeholderBarButtonItemTapped()
}

///Responsible for telling the view what to display and giving user input to the input file.
protocol SettingsPresenting: ModulePresenting {
    func backButtonTapped()
}

///Responsible for digesting user input and sending responses to the output.
protocol SettingsInput: ModuleInput {}

///Responsible for providing feedback to the user or telling the router to route away if necessary.
protocol SettingsOutput: ModuleOutput {}

///Responsible for navigating between the screens on the app as related to this module specifically.
protocol SettingsWireframe: ModuleWireframe {
    func routeBack()
}
