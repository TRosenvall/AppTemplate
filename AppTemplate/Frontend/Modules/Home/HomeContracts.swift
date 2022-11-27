//
//  HomeContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

///Responsible for creating and assembling all the parts of the module.
protocol HomeBuilding: ModuleBuilding {}

///Responsible for building out and setting up the views on the view controller.
protocol HomeConstraining: Constraining {}

///Responsible for displaying information to and getting input from the user.
protocol HomeView: Module {
    var settingsBarButtonItem: UIBarButtonItem { get }
    var placeholderBarButtonItem: UIBarButtonItem { get }
}

///Responsible for telling the view what to display and giving user input to the input file.
protocol HomePresenting {}

///Responsible for digesting user input and sending responses to the output.
protocol HomeInput {}

///Responsible for handling anything that might need to be persisted for this module.
protocol HomeModel: Entity {}

///Responsible for providing feedback to the user or telling the router to route away if necessary.
protocol HomeOutput {}

///Responsible for navigating between the screens on the app as related to this module specifically.
protocol HomeWireframe {}
