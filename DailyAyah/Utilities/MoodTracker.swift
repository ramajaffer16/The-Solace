//
//  MoodTracker.swift
//  DailyAyah
//
//  Created by Ramadhan on 11/11/2025.
//
//  Tracks which moods users select most frequently
//  Used to determine the Verse of the Day
//

import Foundation

struct MoodTracker {
    private static let key = "mood_selection_history"
    private static let lastUpdateKey = "mood_last_update_date"

    // MARK: - Track Mood Selection
    /// Call this whenever a user selects a mood
    static func recordMoodSelection(_ mood: String) {
        var history = loadHistory()
        history[mood, default: 0] += 1
        saveHistory(history)
    }

    // MARK: - Get Most Selected Mood
    /// Returns the mood the user has selected most frequently
    /// Falls back to "Hope" if no history exists
    static func getMostSelectedMood() -> String {
        let history = loadHistory()

        guard !history.isEmpty else {
            return "Hope" // Default fallback
        }

        // Find mood with highest count
        let mostSelected = history.max { $0.value < $1.value }
        return mostSelected?.key ?? "Hope"
    }

    // MARK: - Get All Mood Stats
    /// Returns all moods and their selection counts, sorted by frequency
    static func getMoodStats() -> [(mood: String, count: Int)] {
        let history = loadHistory()
        return history.sorted { $0.value > $1.value }
            .map { (mood: $0.key, count: $0.value) }
    }

    // MARK: - Check if Daily Update Needed
    /// Returns true if we haven't updated the verse today
    static func shouldUpdateDailyVerse() -> Bool {
        guard let lastUpdate = UserDefaults.standard.object(forKey: lastUpdateKey) as? Date else {
            return true // Never updated
        }

        return !Calendar.current.isDateInToday(lastUpdate)
    }

    // MARK: - Mark Daily Update Complete
    static func markDailyUpdateComplete() {
        SharedUserDefaults.shared.set(Date(), forKey: lastUpdateKey)
    }

    // MARK: - Reset (for testing or user preference)
    static func reset() {
        SharedUserDefaults.shared.removeObject(forKey: key)
        SharedUserDefaults.shared.removeObject(forKey: lastUpdateKey)
    }

    // MARK: - Private Helpers
    private static func loadHistory() -> [String: Int] {
        guard let data = SharedUserDefaults.shared.data(forKey: key) else {
            return [:]
        }

        do {
            return try JSONDecoder().decode([String: Int].self, from: data)
        } catch {
            print("⚠️ Error decoding mood history:", error)
            return [:]
        }
    }

    private static func saveHistory(_ history: [String: Int]) {
        do {
            let data = try JSONEncoder().encode(history)
            SharedUserDefaults.shared.set(data, forKey: key)
        } catch {
            print("❌ Error encoding mood history:", error)
        }
    }
}
