//
//  ModuleNamespace.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 3/18/23.
//

import UIKit

///------

enum NavBarOptions: Hashable {
    case inheritNavBar
    case showNavBar
    case hideNavBar
}

enum TabBarOptions: Hashable {
    case inheritTabBar
    case showTabBar(withModules: [UtilityType.Module])
    case hideTabBar
}

///------

enum PresentationType {
    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}

///------

/// Specific to presenting modules. The option will be available to provide a
/// `TransitionAnimator`. This class will contain three things.
class TransitionAnimator {
    /// `modalTransitionStyle` which is an instance of a `ModalTransitionStyle`
    /// used to transition between viewControllers.
    var shouldAnimate: Bool
    var moduleToAnimateOut: (any Module)?
    var moduleToAnimateIn: (any Module)?

    init(shouldAnimate: Bool,
         moduleToAnimateOut: (any Module)? = nil,
         moduleToAnimateIn: (any Module)? = nil) {
        self.shouldAnimate = shouldAnimate
        self.moduleToAnimateOut = moduleToAnimateOut
        self.moduleToAnimateIn = moduleToAnimateIn
    }

    /// `animateOut()` which takes the currently presented view controller and runs any
    /// needed animations on it before moving to the new view controller.
    @MainActor func animateOut(_ completion: (() -> Void)?) {
        if shouldAnimate {
            moduleToAnimateOut?.animator?.animateOut()
        }
        if let completion {
            completion()
        }
    }

    /// `animateIn()` which takes the newly presented view controller and runs any needed
    /// animations on it.
    @MainActor func animateIn(_ completion: (() -> Void)?) {
        if shouldAnimate {
            moduleToAnimateIn?.animator?.animateIn()
        }
        if let completion {
            completion()
        }
    }
}

///------

class ModuleNamespace {
    static func getTransitioner(from firstModule: UIViewController,
                                secondModule: UIViewController,
                                isPresenting: PresentationType) -> (any ModuleAnimatedTransitioning)? {
        var animator: (any ModuleAnimatedTransitioning)?
        
        switch (firstModule, secondModule) {
            // LaunchToHome Transitioner
        case (is any LaunchView, is any HomeView):
            guard let firstModule = firstModule as? any LaunchView,
                  let secondModule = secondModule as? any HomeView
            else { return nil }
            animator = LaunchToHomeTransitioner(type: isPresenting,
                                                firstModule: firstModule,
                                                secondModule: secondModule)
            // HomeToSettings Transitioner
        case (is any HomeView, is any SettingsView):
            guard let firstModule = firstModule as? any HomeView,
                  let secondModule = secondModule as? any SettingsView
            else { return nil }
            animator = HomeToSettingsTransitioner(type: isPresenting,
                                                  firstModule: firstModule,
                                                  secondModule: secondModule)
            // Default Transitioner should return nil to use default present animation
        default:
            return nil
        }
        
        return animator
    }
}
