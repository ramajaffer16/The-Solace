//
//  HomeScreenVM.swift
//  DailyAyah
//
//  Created by Ramadhan on 09/10/2025.
//

//MARK: STUDY THIS CODE
//protocol NetworkManaging{
//    func fetchVerses(for moodData: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void)
//}
//
//protocol localDataManaging {
//    func loadMoodVerses(from fileName: String) -> MoodVerses?
//}
//
//class HomeScreenViewModel {
//    private let networkManager: NetworkManaging
//    private let localManager: localDataManaging
//    var verses: [Verse] = []
//    var coordinator: AppCoordinatorDelegate
//
//    init(coordinator: AppCoordinatorDelegate,networkManager: NetworkManaging, localManager: localDataManaging) {
//        self.coordinator = coordinator
//        self.networkManager = networkManager
//        self.localManager = localManager
//    }
//
//    func loadVerses(for mood: String, completion: @escaping () -> Void) {
//        guard let moodData = localManager.loadMoodVerses(from: mood) else { return }
//
//        networkManager.fetchVerses(for: moodData) {[weak self] result in
//            switch result {
//            case .success(let verses):
//                self?.verses = verses
//                self?.coordinator.goToVersesList(verses: verses)
//                completion()
//            case .failure(let error):
//                print("❌ Error:", error.localizedDescription)
//            }
//        }
//    }
//}

//
//  Enhanced HomeScreenViewModel.swift
//  DailyAyah
//
//  Updated with Verse of the Day, caching, and mood tracking
//

import Foundation

class HomeScreenViewModel {
    private let networkManager: NetworkManaging
    private let localManager: localDataManaging
    var coordinator: AppCoordinatorDelegate

    // State
    var verses: [Verse] = []
    var verseOfTheDay: Verse?
    var isLoadingDaily = false
    var isLoadingMood = false

    // Callbacks for UI updates
    var onDailyVerseLoaded: ((Verse) -> Void)?
    var onMoodVersesLoaded: (() -> Void)?
    var onError: ((String) -> Void)?

    init(coordinator: AppCoordinatorDelegate, networkManager: NetworkManaging, localManager: localDataManaging) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.localManager = localManager
    }

    // MARK: - Load Verse of the Day
    func loadVerseOfTheDay() {
        guard !isLoadingDaily else { return }
        isLoadingDaily = true

        VerseOfTheDayManager.getTodaysVerse(
            networkManager: networkManager,
            localManager: localManager
        ) { [weak self] verse in
            DispatchQueue.main.async {
                self?.isLoadingDaily = false

                if let verse = verse {
                    self?.verseOfTheDay = verse
                    self?.onDailyVerseLoaded?(verse)
                } else {
                    // Fallback to a default verse
                    self?.loadFallbackVerse()
                }
            }
        }
    }

    // MARK: - Load Verses for Mood
    func loadVerses(for mood: String, completion: @escaping () -> Void) {
        guard !isLoadingMood else { return }
        isLoadingMood = true

        // Track this mood selection
        MoodTracker.recordMoodSelection(mood)

        guard let moodData = localManager.loadMoodVerses(from: mood) else {
            isLoadingMood = false
            onError?("Failed to load mood data")
            return
        }

        networkManager.fetchVerses(for: moodData) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingMood = false

                switch result {
                case .success(let verses):
                    self?.verses = verses
                    self?.coordinator.goToVersesList(verses: verses)
                    completion()

                case .failure(let error):
                    print("❌ Error loading verses:", error.localizedDescription)
                    self?.onError?("Failed to load verses. Please check your connection.")
                }
            }
        }
    }

    // MARK: - Refresh Daily Verse
    /// Manually refresh the verse of the day
    func refreshDailyVerse() {
        VerseOfTheDayManager.forceRefresh(
            networkManager: networkManager,
            localManager: localManager
        ) { [weak self] verse in
            DispatchQueue.main.async {
                if let verse = verse {
                    self?.verseOfTheDay = verse
                    self?.onDailyVerseLoaded?(verse)
                }
            }
        }
    }

    // MARK: - Get Mood Statistics
    func getMoodStats() -> [(mood: String, count: Int)] {
        return MoodTracker.getMoodStats()
    }

    // MARK: - Private Helpers
    private func loadFallbackVerse() {
        // Load a default verse (Surah 94:5-6 - "Indeed, with hardship comes ease")
        guard let moodData = localManager.loadMoodVerses(from: "Hope") else {
            return
        }

        networkManager.fetchVerses(for: moodData) { [weak self] result in
            if case .success(let verses) = result, let firstVerse = verses.first {
                DispatchQueue.main.async {
                    self?.verseOfTheDay = firstVerse
                    self?.onDailyVerseLoaded?(firstVerse)
                }
            }
        }
    }
}
