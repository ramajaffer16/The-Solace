//
//  SplashScreenVM.swift
//  DailyAyah
//
//  Created by Ramadhan on 14/10/2025.
//

class SplashScreenViewModel {
  var coordinator: AppCoordinatorDelegate

    init(coordinator: AppCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func goToStartScreen() {
        coordinator.goToStartScreen()
    }
}
