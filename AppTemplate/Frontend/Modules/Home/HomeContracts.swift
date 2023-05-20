//
//  HomeContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

///Responsible for creating and assembling all the parts of the module.
protocol HomeBuilding: ModuleBuilding where ModuleType == any HomeView, ThemeType == HomeTheme {}

///Responsible for any animations pertaining to the Home Module
protocol HomeAnimating: ModuleAnimating {}

///Responsible for displaying information to and getting input from the user.
protocol HomeView: Module {
    func settingsBarButtonItemTapped()

    func placeholderBarButtonItemTapped()
}

///Responsible for telling the view what to display and giving user input to the input file.
protocol HomePresenting: ModulePresenting {
    func settingsButtonTapped()
}

///Responsible for digesting user input and sending responses to the output.
protocol HomeInput: ModuleInput {}

///Responsible for providing feedback to the user or telling the router to route away if necessary.
protocol HomeOutput: ModuleOutput {}

///Responsible for navigating between the screens on the app as related to this module specifically.
protocol HomeWireframe: ModuleWireframe {
    func routeToSettingsModule() throws
}
