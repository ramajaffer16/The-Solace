//
//  CacheManager.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//  Manages local caching of verses to enable offline access
//  and faster loading times
//

import Foundation

struct CacheManager {
    private static let key = "cached_verses"
    private static let expirationDays = 30 // Cache expires after 30 days

    // MARK: - Cache Structure
    private struct CachedVerse: Codable {
        let verse: Verse
        let cachedDate: Date
        let mood: String
    }

    // MARK: - Save Verses to Cache
    /// Caches verses for a specific mood
    static func cache(verses: [Verse], forMood mood: String) {
        var cache = loadCache()

        // Add new verses to cache with current date
        let cachedVerses = verses.map { verse in
            CachedVerse(verse: verse, cachedDate: Date(), mood: mood)
        }

        // Remove old verses for this mood
        cache.removeAll { $0.mood == mood }

        // Add new verses
        cache.append(contentsOf: cachedVerses)

        // Clean expired entries
        cache = cleanExpiredEntries(cache)

        saveCache(cache)
    }

    // MARK: - Retrieve Cached Verses
    /// Returns cached verses for a mood, or nil if not cached/expired
    static func getCachedVerses(forMood mood: String) -> [Verse]? {
        let cache = loadCache()
        let moodVerses = cache.filter { $0.mood == mood && !isExpired($0.cachedDate) }

        guard !moodVerses.isEmpty else { return nil }

        return moodVerses.map { $0.verse }
    }

    // MARK: - Check if Mood is Cached
    static func isCached(mood: String) -> Bool {
        let cache = loadCache()
        return cache.contains { $0.mood == mood && !isExpired($0.cachedDate) }
    }

    // MARK: - Get Specific Verse from Cache
    /// Useful for Verse of the Day - gets a specific verse if cached
    static func getCachedVerse(surah: Int, ayah: Int) -> Verse? {
        let cache = loadCache()
        return cache.first {
            $0.verse.surahNumber == surah &&
            $0.verse.ayahNumber == ayah &&
            !isExpired($0.cachedDate)
        }?.verse
    }

    // MARK: - Clear Cache
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }

    static func clearMood(_ mood: String) {
        var cache = loadCache()
        cache.removeAll { $0.mood == mood }
        saveCache(cache)
    }

    // MARK: - Cache Statistics
    static func getCacheStats() -> (totalVerses: Int, moodsCached: Int, oldestCache: Date?) {
        let cache = loadCache()
        let validCache = cache.filter { !isExpired($0.cachedDate) }
        let uniqueMoods = Set(validCache.map { $0.mood }).count
        let oldestDate = validCache.map { $0.cachedDate }.min()

        return (totalVerses: validCache.count, moodsCached: uniqueMoods, oldestCache: oldestDate)
    }

    // MARK: - Private Helpers
    private static func loadCache() -> [CachedVerse] {
        guard let data = SharedUserDefaults.shared.data(forKey: key) else {
            return []
        }

        do {
            return try JSONDecoder().decode([CachedVerse].self, from: data)
        } catch {
            print("⚠️ Error decoding cache:", error)
            return []
        }
    }

    private static func saveCache(_ cache: [CachedVerse]) {
        do {
            let data = try JSONEncoder().encode(cache)
            SharedUserDefaults.shared.set(data, forKey: key)
        } catch {
            print("❌ Error encoding cache:", error)
        }
    }

    private static func isExpired(_ date: Date) -> Bool {
        guard let expirationDate = Calendar.current.date(
            byAdding: .day,
            value: expirationDays,
            to: date
        ) else {
            return true
        }

        return Date() > expirationDate
    }

    private static func cleanExpiredEntries(_ cache: [CachedVerse]) -> [CachedVerse] {
        return cache.filter { !isExpired($0.cachedDate) }
    }
}
