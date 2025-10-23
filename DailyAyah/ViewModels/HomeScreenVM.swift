//
//  HomeScreenVM.swift
//  DailyAyah
//
//  Created by Ramadhan on 09/10/2025.
//

//MARK: STUDY THIS CODE
class HomeScreenViewModel {
    private let networkManager = NetworkManager.shared
    private let localManager = LocalDataManager()
    var verses: [Verse] = []
    var coordinator: AppCoordinatorDelegate

    init(coordinator: AppCoordinatorDelegate) {
        self.coordinator = coordinator
    }

    func loadVerses(for mood: String, completion: @escaping () -> Void) {
        guard let moodData = localManager.loadMoodVerses(from: mood) else { return }

        networkManager.fetchVerses(for: moodData) {[weak self] result in
            switch result {
            case .success(let verses):
                self?.verses = verses
                self?.coordinator.goToVersesList(verses: verses)
                completion()
            case .failure(let error):
                print("❌ Error:", error.localizedDescription)
            }
        }
    }
}
