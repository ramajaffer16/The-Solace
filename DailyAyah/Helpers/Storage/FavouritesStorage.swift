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
    static func add(_ ayah: FavouriteAyah) {
        var favourites = load()
        if !favourites.contains(ayah) {
            favourites.append(ayah)
            save(favourites)
        }
    }

    // MARK: - Remove a favourite
    static func remove(_ ayah: FavouriteAyah) {
        var favourites = load()
        favourites.removeAll { $0 == ayah }
        save(favourites)
    }

    // MARK: - Load all favourites
    static func load() -> [FavouriteAyah] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([FavouriteAyah].self, from: data)
        } catch {
            print("❌ Error decoding favourites:", error)
            return []
        }
    }

    // MARK: - Clear all (optional utility)
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }

    // MARK: - Private helper
    private static func save(_ favourites: [FavouriteAyah]) {
        do {
            let data = try JSONEncoder().encode(favourites)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("❌ Error encoding favourites:", error)
        }
    }
}
