//
//  ModuleResolver.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

// Unlike services, which all sit in the back doing their thing, we want to load these only as needed.
protocol ModuleResolving: Actor {

    static var shared: ModuleResolving { get }

    var rootViewController: any RootView { get async }
    var appTheme: AppTheme { get async }
    var activityIndicator: ActivityIndicatorView? { get async }

    func resolveModule<T: Module>(ofType moduleType: UtilityType.Module,
                                  shouldPresent: Bool,
                                  shouldAnimateIfPresenting: Bool,
                                  navBarOption: NavBarOptions?,
                                  tabBarOption: TabBarOptions?,
                                  presentationStyle: UIModalPresentationStyle?) async -> T
}

// Default Implementation
extension ModuleResolving {
    func resolveModule<T: Module>(ofType moduleType: UtilityType.Module,
                                  shouldPresent: Bool = false,
                                  shouldAnimateIfPresenting: Bool = true,
                                  navBarOption: NavBarOptions? = nil,
                                  tabBarOption: TabBarOptions? = nil,
                                  presentationStyle: UIModalPresentationStyle? = nil) async -> T {
        return await self.resolveModule(ofType: moduleType,
                                        shouldPresent: shouldPresent,
                                        shouldAnimateIfPresenting: shouldAnimateIfPresenting,
                                        navBarOption: navBarOption,
                                        tabBarOption: tabBarOption,
                                        presentationStyle: presentationStyle)
    }
}

actor ModuleResolver: ModuleResolving {

    // MARK: - Properties
    static let shared: ModuleResolving = ModuleResolver()

    private var _rootViewController: (any RootView)? = nil
    var rootViewController: any RootView {
        get async {
            if _rootViewController == nil {
                _rootViewController = await RootViewController()
            }
            guard let _rootViewController else {
                fatalError("Unable to initialize RootViewController")
            }
            return _rootViewController
        }
    }

    var appTheme = AppTheme()

    var activityIndicator: ActivityIndicatorView? {
        get async {
            return await rootViewController.activityIndicator
        }
    }

    var activeModule: UtilityType.Module? = nil

    var linkedToModules: [UtilityType.Module] = []

    // MARK: - Initializers
    init() {}

    // MARK: - ModuleResolving Functions
    @discardableResult func resolveModule<T: Module>(ofType moduleType: UtilityType.Module,
                                                     shouldPresent: Bool = false,
                                                     shouldAnimateIfPresenting: Bool = true,
                                                     navBarOption: NavBarOptions? = .inheritNavBar,
                                                     tabBarOption: TabBarOptions? = .inheritTabBar,
                                                     presentationStyle: UIModalPresentationStyle? = nil) async -> T {
        var module: T? = await rootViewController.searchForModule()
        if module == nil {
            switch moduleType {
            case .Launch: module = resolveLaunchModule() as? T
            case .Home: module = resolveHomeModule() as? T
            case .Settings: module = resolveSettingsModule() as? T
            }
        }
        guard let module else { fatalError("Unable to resolve module of type: \(moduleType)") }

        if shouldPresent {
            await self.rootViewController.present(module,
                                                  animated: shouldAnimateIfPresenting)
        }
        return module
    }

    func resolveLaunchModule() -> any LaunchView {
        let launchBuilder = LaunchBuilder(theme: appTheme.launchTheme)
        let launchModule = launchBuilder.buildModule()
        activeModule = .Launch
        linkedToModules = [.Home]
        return launchModule
    }

    func resolveSettingsModule() -> any SettingsView {
        let settingsBuilder = SettingsBuilder(theme: appTheme.settingsTheme)
        let settingsModule = settingsBuilder.buildModule()
        activeModule = .Settings
        linkedToModules = [.Home]
        return settingsModule
    }

    func resolveHomeModule() -> any HomeView {
        let homeBuilder = HomeBuilder(theme: appTheme.homeTheme)
        let homeModule = homeBuilder.buildModule()
        activeModule = .Home
        linkedToModules = [.Settings]
        return homeModule
    }

    // MARK: - Helper Functions
}
