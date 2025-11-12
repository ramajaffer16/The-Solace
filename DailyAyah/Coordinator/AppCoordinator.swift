//
//  HomeCoordinator.swift
//  DailyAyah
//
//  Created by Ramadhan on 08/10/2025.
//

import UIKit

protocol AppCoordinatorDelegate: AnyObject {
   func goToHome()
   func goToLogin()
   func goToGetStarted()
   func goToStartScreen()
    func goToVersesList(verses: [Verse])
    func goToNextStartScreen()
}

class AppCoordinator: AppCoordinatorDelegate {
    let navigationController: UINavigationController
    let networkManager: EnhancedNetworkManager // Changed
    let localDataManager: LocalDataManager

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.networkManager = EnhancedNetworkManager.shared // Changed
        self.localDataManager = LocalDataManager()
        start()
    }

    func start() {
        let viewModel = SplashScreenViewModel(coordinator: self)
        let viewController = SplashViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
  }

    func goToNextStartScreen() {
        // Check if user has completed onboarding
        let hasCompletedOnboarding = SharedUserDefaults.shared.bool(forKey: "hasCompletedOnboarding")

        if hasCompletedOnboarding {
            // Go directly to home
            goToStartScreen()
        } else {
            // Show onboarding
            showOnboarding()
        }
    }

    func showOnboarding() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.onComplete = { [weak self] in
            self?.goToHome()
        }
        navigationController.setViewControllers([onboardingVC], animated: false)
    }

    func goToStartScreen() {
        let viewModel = StartScreenViewModel(coordinator: self)
        viewModel.coordinatior = self
        let loginViewController = StartScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func goToHome() {
        // MARK: - Home
        let homeVM = HomeScreenViewModel(coordinator: self, networkManager: networkManager, localManager: localDataManager)
        let homeVC = HomeScreenViewController(viewModel: homeVM)
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        // MARK: - Favourites
        let favouritesVM = FavouritesViewModel(coordinator: self)
        let favouritesVC = FavouritesViewController(viewModel: favouritesVM)
        favouritesVC.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )

        // MARK: - Settings
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))

        // MARK: - Navigation wrappers
        let homeNav = UINavigationController(rootViewController: homeVC)
        let favouritesNav = UINavigationController(rootViewController: favouritesVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)

        // MARK: - Tab Bar setup
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, favouritesNav, settingsNav]

        // Theme consistent with your app
        tabBarController.tabBar.tintColor = UIColor(named: "Forest")
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.backgroundColor = UIColor(named: "Cream")

        // MARK: - Set as root
        navigationController.setViewControllers([tabBarController], animated: true)
    }


    func goToLogin() {
       let viewModel = LoginScreenVM(coordinator: self)
       let viewController = LoginScreenViewController(viewModel: viewModel)
       navigationController.pushViewController(viewController, animated: true)
    }

    func goToGetStarted() {
        let viewModel = RegisterScreenViewModel(coordinator: self)
        let viewController = RegisterScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToVersesList(verses: [Verse]) {
        let viewModel = VersesListViewModel(coordinator: self,verses: verses)
        let viewController = VersesListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToFavourites() {
        let viewModel = FavouritesViewModel(coordinator: self)
        let viewController = FavouritesViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        navigationController.pushViewController(viewController, animated: true)
    }
}
