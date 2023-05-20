//
//  ModuleContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

///------

protocol Theme {
    func apply()
}

///------

protocol ModuleVariable: Variable {
    static var onDeck: [UtilityType.Module] { get set }
}

///------

protocol Module: UIViewController,
                 UIViewControllerTransitioningDelegate {
    associatedtype ViewTheme

    var theme: ViewTheme { get }
    var presenter: (any ModulePresenting)? { get set }
    var animator: (any ModuleAnimating)? { get set }
    
    init(theme: ViewTheme)
}

extension Module {
    init(theme: ViewTheme) {
        self.init(theme: theme)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModuleNamespace.getTransitioner(from: presenting,
                                               secondModule: presented,
                                               isPresenting: .present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModuleNamespace.getTransitioner(from: self,
                                               secondModule: dismissed,
                                               isPresenting: .dismiss)
    }
}

///------

protocol ModuleTheme: Theme {
    associatedtype Controller: Module

    var viewController: Controller? { get set }
    var tabBarTheme: TabBarTheme? { get async }
    var navBarTheme: NavBarTheme? { get async }
}

///------

protocol ModuleBuilding {

    /// Will define the type of service being built.
    associatedtype ModuleType
    associatedtype ThemeType

    /// Builds and returns the module's viewController
    func buildModule() -> ModuleType
}

///------

protocol ModuleAnimating {
    var module: (any Module)? { get }

    func animateIn()
    func animateOut()
}

///------

// Default implementation
class UIViewControllerAnimatedTransitioner: NSObject, UIViewControllerAnimatedTransitioning {
    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return K.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        return
    }
}

protocol ModuleAnimatedTransitioning: UIViewControllerAnimatedTransitioner {
    associatedtype FirstModule
    associatedtype SecondModule

    var type: PresentationType { get }

    init?(type: PresentationType,
          firstModule: FirstModule,
          secondModule: SecondModule)
}

///------

protocol ModulePresenting {
    var view: (any Module) { get }
    var interactor: (any ModuleInput)? { get }
    var router: (any ModuleWireframe)? { get }
}

///------

protocol ModuleInput {
    var entityController: any ModelControlling { get }
    var output: (any ModuleOutput)? { get }
}

///------

protocol ModuleOutput {}

///------

protocol ModuleWireframe {}

///------

protocol Component: UIView {}

protocol ComponentTheme: Theme {
    var view: Component? { get set }
}

///------
