//
//  SceneDelegate.swift
//  DailyAyah
//
//  Created by Ramadhan on 22/09/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: AppCoordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navController)   // ← your root VC
        window.rootViewController = navController
        window.makeKeyAndVisible()

        self.window = window
        self.coordinator = coordinator

    }

}

