//
//  VerseOfTheDayManager.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//
//  Manages the daily verse selection based on user's mood preferences
//

import Foundation

struct VerseOfTheDayManager {
    private static let key = "verse_of_the_day"
    private static let lastVerseKey = "last_verse_reference"

    // MARK: - Daily Verse Structure
    struct DailyVerse: Codable {
        let verse: Verse
        let date: Date
        let mood: String
    }

    // MARK: - Get Today's Verse
    /// Returns today's verse, fetching a new one if needed
    static func getTodaysVerse(
        networkManager: NetworkManaging,
        localManager: localDataManaging,
        completion: @escaping (Verse?) -> Void
    ) {
        // Check if we already have today's verse
        if let todaysVerse = loadTodaysVerse() {
            completion(todaysVerse.verse)
            return
        }

        // Need to fetch a new verse
        fetchNewDailyVerse(
            networkManager: networkManager,
            localManager: localManager,
            completion: completion
        )
    }

    // MARK: - Fetch New Daily Verse
    private static func fetchNewDailyVerse(
        networkManager: NetworkManaging,
        localManager: localDataManaging,
        completion: @escaping (Verse?) -> Void
    ) {
        // Get user's most selected mood
        let mood = MoodTracker.getMostSelectedMood()

        // Load verses for that mood
        guard let moodData = localManager.loadMoodVerses(from: mood) else {
            print("❌ Failed to load mood data for: \(mood)")
            completion(nil)
            return
        }

        // Check cache first
        if let cachedVerses = CacheManager.getCachedVerses(forMood: mood), !cachedVerses.isEmpty {
            let selectedVerse = selectRandomVerse(from: cachedVerses, mood: mood)
            saveDailyVerse(selectedVerse, mood: mood)
            MoodTracker.markDailyUpdateComplete()
            completion(selectedVerse)
            return
        }

        // Fetch from network
        networkManager.fetchVerses(for: moodData) { result in
            switch result {
            case .success(let verses):
                // Cache the verses
                CacheManager.cache(verses: verses, forMood: mood)

                // Select and save today's verse
                let selectedVerse = selectRandomVerse(from: verses, mood: mood)
                saveDailyVerse(selectedVerse, mood: mood)
                MoodTracker.markDailyUpdateComplete()
                completion(selectedVerse)

            case .failure(let error):
                print("❌ Error fetching daily verse:", error.localizedDescription)
                completion(nil)
            }
        }
    }

    // MARK: - Smart Verse Selection
    /// Selects a verse intelligently, avoiding recent repetitions
    private static func selectRandomVerse(from verses: [Verse], mood: String) -> Verse {
        guard !verses.isEmpty else {
            fatalError("Cannot select from empty verse array")
        }

        // Get last shown verse reference
        let lastReference = UserDefaults.standard.string(forKey: lastVerseKey)

        // Try to avoid showing the same verse as yesterday
        let availableVerses = verses.filter { verse in
            let reference = "\(verse.surahNumber):\(verse.ayahNumber)"
            return reference != lastReference
        }

        // If we filtered out all verses, use the full list
        let selectionPool = availableVerses.isEmpty ? verses : availableVerses

        // Select random verse
        let selectedVerse = selectionPool.randomElement()!

        // Save reference for next time
        let reference = "\(selectedVerse.surahNumber):\(selectedVerse.ayahNumber)"
        UserDefaults.standard.set(reference, forKey: lastVerseKey)

        return selectedVerse
    }

    // MARK: - Load Today's Verse
    private static func loadTodaysVerse() -> DailyVerse? {
        guard let data = SharedUserDefaults.shared.data(forKey: key) else {
            return nil
        }

        do {
            let dailyVerse = try JSONDecoder().decode(DailyVerse.self, from: data)

            // Check if it's still today
            if Calendar.current.isDateInToday(dailyVerse.date) {
                return dailyVerse
            } else {
                return nil // Verse is from a previous day
            }
        } catch {
            print("⚠️ Error decoding daily verse:", error)
            return nil
        }
    }

    // MARK: - Save Daily Verse
    private static func saveDailyVerse(_ verse: Verse, mood: String) {
        let dailyVerse = DailyVerse(verse: verse, date: Date(), mood: mood)

        do {
            let data = try JSONEncoder().encode(dailyVerse)
            SharedUserDefaults.shared.set(data, forKey: key)
        } catch {
            print("❌ Error encoding daily verse:", error)
        }
    }

    // MARK: - Force Refresh
    /// Manually refresh the verse (useful for testing or user request)
    static func forceRefresh(
        networkManager: NetworkManaging,
        localManager: localDataManaging,
        completion: @escaping (Verse?) -> Void
    ) {
        // Clear today's verse
        SharedUserDefaults.shared.removeObject(forKey: key)

        // Fetch new one
        fetchNewDailyVerse(
            networkManager: networkManager,
            localManager: localManager,
            completion: completion
        )
    }

    // MARK: - Get Current Mood
    /// Returns the mood of today's verse
    static func getTodaysMood() -> String? {
        return loadTodaysVerse()?.mood
    }
}
