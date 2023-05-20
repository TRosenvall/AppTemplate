//
//  RootViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/26/23.
//

import UIKit

// Root view controller should be instantiated only once per navigation stack and
// should always be the last instance on the navigation stack as it will hold its
// own copy of a navigation stack. So any future pushes should occur on that instance
// of the rootViewController. A new root view controller should be instantiated if
// a view controller is pushed with the parameters to include a nav bar, a tab bar, or
// a different form of modalarity than the current rootViewController. The new
// rootViewController also needs to have access to the parent rootViewController
class RootViewController: UIViewController, RootView {

    // Module Properties
    typealias ViewTheme = AppTheme
    var theme: AppTheme

    // UI Elements

    lazy var activityIndicator: ActivityIndicatorView = {
        let activityIndicator = ActivityIndicatorView(
            frame: view.frame,
            theme: theme.activityIndicatorTheme
        )
        self.view.addSubview(activityIndicator)
        return activityIndicator
    }()

    lazy var navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navBar)
        navBar.backgroundColor = .cyan

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 80)
        ])

        return navBar
    }()

    lazy var tabBar: TabBar = {
        let tabBar = TabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tabBar)
        tabBar.backgroundColor = .red

        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        return tabBar
    }()

    // Presentation Options
    var navBarOption: NavBarOptions
    var tabBarOption: TabBarOptions
    var presentationStyle: UIModalPresentationStyle

    // Navigation Properties
    var parentRootViewController: (any RootView)?

    var navigationStacks: [[any Module]] = [[]]

    var containerViews: [UIView] = []

    var activeNavigationStackIndex: Int = -1 {
        didSet {
            if activeNavigationStackIndex >= 0 {
                for view in containerViews {
                    view.alpha = 0
                }
                containerViews[activeNavigationStackIndex].alpha = 1
            }
        }
    }

    var hasNavBar: Bool {
        if navBarOption == .inheritNavBar,
           let parentRootViewController {
            return parentRootViewController.hasNavBar
        }
        if navBarOption == .showNavBar {
            return true
        }
        return false
    }

    var tabBarModules: [UtilityType.Module] {
        if tabBarOption == .inheritTabBar,
           let parentRootViewController {
            return parentRootViewController.tabBarModules
        }
        if case let .showTabBar(modules) = tabBarOption {
            return modules
        }
        return []
    }

    var numberOfTabs: Int {
        return tabBarModules.count
    }

    var activeModule: any Module {
        if activeNavigationStack.last is (any RootView),
           let nextRoot = activeNavigationStack.last as? (any RootView) {
            return nextRoot.activeModule
        }
        return activeNavigationStack.last ?? self
    }

    var activeNavigationStack: [any Module] {
        _read { yield navigationStacks[activeNavigationStackIndex] }
        _modify { yield &navigationStacks[activeNavigationStackIndex] }
    }

    var activeContainerView: UIView {
        get { return containerViews[activeNavigationStackIndex] }
        set { containerViews[activeNavigationStackIndex] = newValue }
    }

    init(navBarOption: NavBarOptions = .hideNavBar,
         tabBarOption: TabBarOptions = .hideTabBar,
         presentationStyle: UIModalPresentationStyle = .fullScreen,
         instantiateOn rootViewController: RootViewController? = nil) async {
        self.theme = await ModuleResolver.shared.appTheme
        self.navBarOption = navBarOption
        self.tabBarOption = tabBarOption
        self.presentationStyle = presentationStyle
        self.parentRootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = theme.colors.viewBackgroundColor

        // Add navBar and tabBar as needed
        if hasNavBar {
            _ = navBar
        }
        if numberOfTabs > 1 {
            _ = tabBar
        }

        Task { @MainActor in
            if tabBarModules.isEmpty {
                // If modules is empty, then we have the launch screen
                let launchModule = await ModuleResolver.shared.resolveModule(ofType: .Launch,
                                                                             shouldPresent: true,
                                                                             shouldAnimateIfPresenting: false,
                                                                             navBarOption: nil,
                                                                             tabBarOption: nil,
                                                                             presentationStyle: nil)
                self.navigationStacks = [[ launchModule ]]
                self.containerViews = [ createContainerViewFor(module: launchModule) ]
            } else {
                // Otherwise iterate through each utility passed in and resolve them in order.
                for moduleType in tabBarModules {
                    let module = await ModuleResolver.shared.resolveModule(ofType: moduleType,
                                                                           shouldPresent: true,
                                                                           shouldAnimateIfPresenting: false,
                                                                           navBarOption: nil,
                                                                           tabBarOption: nil,
                                                                           presentationStyle: nil)
                    self.navigationStacks.append( [ module ] )
                    self.containerViews.append( createContainerViewFor(module: module) )
                }
            }
            self.activeNavigationStackIndex = 0
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Add activityIndicator
        _ = activityIndicator
    }

    /// This is a recusive search function broken into two parts.
    ///   1. It finds the highest level rootViewController
    ///   2. It iterates through each navigation stack looking for the given module.
    /// This function should be called with the default arguments
    func searchForModule<T: Module>(fromTopLevel: Bool) -> T? {
        // Get back to the bottom root view controller
        if !fromTopLevel {
            if let parentRootViewController {
                return parentRootViewController.searchForModule(fromTopLevel: fromTopLevel)
            } else {
                return self.searchForModule(fromTopLevel: true)
            }
        }
        // Iterate through each navigation stack
        var caughtModule: T? = nil
        for navigationStack in navigationStacks {
            if caughtModule == nil {
                for module in navigationStack {
                    // Check if each module is the required type, if so then done.
                    if module is T {
                        return module as? T
                    }
                    // If the module is another root View, then we'll search that one instead.
                    if let root = module as? any RootView {
                        caughtModule = root.searchForModule(fromTopLevel: fromTopLevel)
                        break
                    }
                }
            } else {
                break
            }
        }
        return caughtModule
    }

    func present(_ module: any Module,
                 presentationStyle: UIModalPresentationStyle = .fullScreen,
                 navBarOption: NavBarOptions = .inheritNavBar,
                 tabBarOption: TabBarOptions = .inheritTabBar,
                 shouldAnimate animate: Bool = true,
                 completion: (() -> Void)?) {
        Task { @MainActor in
            // If the presentationStyle, navBarOption, and tabBarOption don't match the current root's,
            // we present a new root view controller which contains the desired module
            var moduleToPresent: any Module
            if presentationStyle != self.presentationStyle,
               navBarOption != navBarOption,
               tabBarOption != tabBarOption {
                var newRootView: any RootView = await RootViewController(navBarOption: navBarOption,
                                                                         tabBarOption: tabBarOption,
                                                                         presentationStyle: presentationStyle)
                newRootView.present(module, animated: false)
                moduleToPresent = newRootView
            } else {
                moduleToPresent = module
            }

            var transitionAnimator = TransitionAnimator(shouldAnimate: animate,
                                                        moduleToAnimateOut: activeModule,
                                                        moduleToAnimateIn: moduleToPresent)
            transitionAnimator.animateOut {
                self.activeModule.present(moduleToPresent, animated: animate) {
                    transitionAnimator.animateIn(completion)
                }
            }
        }
    }

    func createContainerViewFor(module: any Module) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.backgroundColor = .blue

        addChild(module)
        module.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(module.view)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor),

            module.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            module.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            module.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            module.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        return containerView
    }
}
