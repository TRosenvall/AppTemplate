//
//  RootView.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 4/16/23.
//

import UIKit

/// The RootView is a UIViewController which manages and maintains all views in and on the
/// various navigation stacks. Primary to the rootView are the `parentRootView` and the
/// `presentationOptions`. When a new module is presented, if the `presentationOptions` provided
/// with the new module differ from the currently used `presentationOptions`, then a new `RootView`
/// is instantiated with these new `presentationOptions` and the module is pushed onto it.
/// Additionally, we have three cases we need to cover within the `presentationOptions`.
///
/// Furthermore, the rootViewController preserves a list of all navigation stacks available and all
/// modules presented thereon.
protocol RootView: Module {
    /// This is an option rootViewController in order to reference the parent root view
    /// controller should it be available
    var parentRootViewController: (any RootView)? { get }

    /// This is a copy of the general app theme available throughout the entire application.
    var theme: AppTheme { get }

    /// This is a copy of the activity indicator. This activity indicator is available on all modules
    /// presented on this rootView.
    var activityIndicator: ActivityIndicatorView { get }

    ///   NavBarOptions - This object will be editable via the module theme of the presented module.
    ///     a. InheritNavBar - This is the default option. This will not change the current
    ///     presentation option.
    ///     b. ShowNavBar - If the `navBar` is hidden, then this option will place the `navBar`
    ///     onto the screen.
    ///     c. HideNavBar - If the `navBar` is shown, then this option will remove the `navBar`
    ///     from the screen.
    var navBarOption: NavBarOptions { get }

    ///   TabBarOptions
    ///     a. InheritTabBar - This is the default option. This will not change the current
    ///     presentation option.
    ///     b. ShowTabBar(withModules: UtilityType.Module) - If the `tabBar` is hidden or is
    ///     presenting a `tabBar` with different tabs than specified, then this will present
    ///     a new `tabBar` with the requested modules. In the case of presenting a module, the
    ///     presenting module will not exist in the `tabBar` unless specified.
    var tabBarOption: TabBarOptions { get }

    ///   ModalPresentationOptions - This is as provided by apple.
    var presentationStyle: UIModalPresentationStyle { get }

    /// An boolean indicating whether the user has requested the navBar be available on this root
    var hasNavBar: Bool { get }

    /// A list of the modules to be made available on the `tabBar`
    var tabBarModules: [UtilityType.Module] { get }

    /// The amount of tabs to be made available on the `tabBar`
    var numberOfTabs: Int { get }

    /// This is the `Module` currently being presented on the screen.
    var activeModule: any Module { get }

    /// This is the index of the selected tab within the `tabBar`.
    var activeNavigationStackIndex: Int { get set }

    /// This is the currently selected navigation stack as identified by the
    /// `activeNavigationStackIndex`
    var activeNavigationStack: [any Module] { get }

    /// This is an array of all the different navigation stacks. There will be one navigation
    /// stack created for each tab in the `tabBar`. Each of these stacks will start with a single
    /// module in it as identified by the modules passed into the `tabBarOptions`
    var navigationStacks: [[any Module]] { get set }

    /// This is an array of UIViews. These views stretch from the top of the `tabBar` to the bottom
    /// of the `navBar`. If both are hidden, then these views will take up the full screen. Each of
    /// these views will contain as a subview one of the modules passed in for the `tabBarOptions`.
    /// In the case that the `tabBarOptions` are set on a module not included on the list. The
    /// module being pushed will be presented on the main view of the `RootView`. Touching one of the
    /// `tabBar` buttons will then display the associated module.
    /// TODO: - I need a way to retrieve currently available modules from past `tabBars` and push them
    /// up the stack.
    var containerViews: [UIView] { get set }

    /// The currently shown container view.
    var activeContainerView: UIView { get set }

    /// Searches through the navigation stacks in order to if the requested module has already been presented.
    /// If so, the module is returned.
    func searchForModule<T: Module>(fromTopLevel: Bool) -> T?

    /// Presents the new module using custom options. If the presentationStyle, navBarOption, and tabBarOption
    /// differ from the current rootView, then a new one is instantiated with them and the module passed in will
    /// be presented on it.
    func present(_ module: any Module,
                 presentationStyle: UIModalPresentationStyle,
                 navBarOption: NavBarOptions,
                 tabBarOption: TabBarOptions,
                 shouldAnimate animate: Bool,
                 completion: (() -> Void)?)
}

/// Default Implementation
extension RootView {

    // This should always be nil in the root view.
    var presenter: (ModulePresenting)? {
        get { return nil }
        set {}
    }

    var animator: (ModuleAnimating)? {
        get { return activeModule.animator }
        set {} // In the rootView, we won't be doing anything by trying to set this.
    }

    func searchForModule<T: Module>(fromTopLevel: Bool = false) -> T? {
        return searchForModule(fromTopLevel: fromTopLevel)
    }
}
