//
//  FavouritesStorage.swift
//  DailyAyah
//
//  Created by Ramadhan on 25/10/2025.
//

import Foundation

struct FavouritesStorage {
    private static let key = "favourite_ayahs"

    // MARK: - Save a new favourite
    static func add(_ ayah: Verse) {
        var favourites = load()
        if !favourites.contains(ayah) {
            favourites.append(ayah)
            save(favourites)
        }
    }

    // MARK: - Remove a favourite
    static func remove(_ ayah: Verse) {
        var favourites = load()
        favourites.removeAll { $0 == ayah }
        save(favourites)
    }

    // MARK: - Load all favourites
    static func load() -> [Verse] {
        guard let data = SharedUserDefaults.shared.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([Verse].self, from: data)
        } catch {
            print(" Error decoding favourites:", error)
            return []
        }
    }

    // MARK: - Clear all (optional utility)
    static func clearAll() {
        SharedUserDefaults.shared.removeObject(forKey: key)
    }

    // MARK: - Private helper
    private static func save(_ favourites: [Verse]) {
        do {
            let data = try JSONEncoder().encode(favourites)
            SharedUserDefaults.shared.set(data, forKey: key)
        } catch {
            print("❌ Error encoding favourites:", error)
        }
    }
}
