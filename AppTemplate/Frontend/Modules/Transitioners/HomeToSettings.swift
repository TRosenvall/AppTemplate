//
//  HomeToSettings.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 4/26/23.
//

import UIKit

class HomeToSettingsTransitioner: UIViewControllerAnimatedTransitioner, ModuleAnimatedTransitioning {
    typealias FirstModule = any HomeView
    typealias SecondModule = any SettingsView

    internal let type: PresentationType
    internal let homeView: any HomeView
    internal let settingsView: any SettingsView

    required init?(type: PresentationType,
                   firstModule homeView: any HomeView,
                   secondModule settingsView: any SettingsView) {
        self.type = type
        self.homeView = homeView
        self.settingsView = settingsView

        guard let _ = homeView.view.window ?? settingsView.view.window
        else { return nil }
    }

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = homeView.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        // Add custom transition here
        return
    }
}

// Template
//class Module1ToModule2Transitioner: UIViewControllerAnimatedTransitioner, ModuleAnimatedTransitioning {
//    typealias FirstModule = any Module1
//    typealias SecondModule = any Module2
//
//    internal let type: PresentationType
//    internal let homeView: any Module1
//    internal let settingsView: any Module2
//
//    required init?(type: PresentationType,
//                   firstModule module1: any Module1,
//                   secondModule module2: any Module2) {
//        self.type = type
//        self.module1 = module1
//        self.module2 = module2
//
//        guard let _ = module1.view.window ?? module2.view.window
//        else { return nil }
//    }
//
//    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//
//        guard let toView = module1.view
//        else {
//            transitionContext.completeTransition(false)
//            return
//        }
//
//        containerView.addSubview(toView)
//
//        // Add custom transition here
//        return
//    }
//}
