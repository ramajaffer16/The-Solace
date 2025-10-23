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
}

class AppCoordinator: AppCoordinatorDelegate {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        start()
    }

    func start() {
        let viewModel = SplashScreenViewModel(coordinator: self)
        let viewController = SplashViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
  }

    func goToStartScreen() {
        let viewModel = StartScreenViewModel(coordinator: self)
        viewModel.coordinatior = self
        let loginViewController = StartScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func goToHome() {
     let viewModel = HomeScreenViewModel(coordinator: self)
        let viewController = HomeScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
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
}
