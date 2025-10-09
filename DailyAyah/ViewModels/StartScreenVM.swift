//
//  LoginViewModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 08/10/2025.
//

class StartScreenViewModel {
    var coordinatior: AppCoordinatorDelegate

    init(coordinator: AppCoordinatorDelegate){
        self.coordinatior = coordinator
    }

    func loginButtonTapped() {
       coordinatior.goToLogin()
    }

    func getStartedButtonTapped() {
        coordinatior.goToGetStarted()
    }

}
