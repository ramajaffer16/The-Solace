//
//  Untitled.swift
//  DailyAyah
//
//  Created by Ramadhan on 09/10/2025.
//

class LoginScreenVM {
    var coordinator: AppCoordinatorDelegate

    init (coordinator: AppCoordinatorDelegate) {
      self.coordinator = coordinator
    }

    func goToLogin() {
        coordinator.goToLogin()
    }

    func goToHomeScreen() {
        coordinator.goToHome()
    }

}
