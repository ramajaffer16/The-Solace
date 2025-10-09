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
}

class AppCoordinator: AppCoordinatorDelegate {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        start()
    }

    func start() {
        let viewModel = StartScreenViewModel(coordinator: self)
        viewModel.coordinatior = self
        let loginViewController = StartScreenViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: false)
  }

    func goToHome() {
//        let viewModel = HomeScreenViewModel()
//        let viewController = HomeScreenViewController(viewModel: viewModel)

    }

    func goToLogin() {
       let viewModel = 
    }

    func goToGetStarted() {
        
    }
}
