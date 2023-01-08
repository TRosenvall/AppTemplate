//
//  SceneDelegate.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Task {
            do {
                let appTheme = AppTheme()
                let moduleResolver = ModuleResolver(appTheme: appTheme)
                
                guard let windowScene = (scene as? UIWindowScene) else { return }
                
                window = UIWindow(windowScene: windowScene)
                window?.rootViewController = try await moduleResolver.resolveLaunchModule()
                window?.makeKeyAndVisible()
            } catch {
                print("Oops")
                print(error)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

