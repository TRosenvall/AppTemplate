//
//  LaunchToHome.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 4/25/23.
//

import UIKit

class LaunchToHomeTransitioner: UIViewControllerAnimatedTransitioner, ModuleAnimatedTransitioning {
    typealias FirstModule = any LaunchView
    typealias SecondModule = any HomeView

    internal let type: PresentationType
    internal let launchView: any LaunchView
    internal let homeView: any HomeView

    required init?(type: PresentationType,
                   firstModule launchView: any LaunchView,
                   secondModule homeView: any HomeView) {
        self.type = type
        self.launchView = launchView
        self.homeView = homeView

        guard let _ = launchView.view.window ?? homeView.view.window
        else { return nil }
    }

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = launchView.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        // Add custom transition here
        return
    }
}
