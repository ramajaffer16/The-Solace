//
//  LocalDataManager.swift
//  DailyAyah
//
//  Created by Ramadhan on 21/10/2025.
//

//MARK: - HAVE TO STUDY THIS CODE

import Foundation

class LocalDataManager {
    func loadMoodVerses(from fileName: String) -> MoodVerses? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MoodVerses.self, from: data)
        } catch {
            print("❌ Error loading \(fileName):", error)
            return nil
        }
    }
}

