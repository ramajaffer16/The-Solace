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
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("❌ File not found in bundle: \(fileName).json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            print("✅ Loaded \(fileName).json, size: \(data.count) bytes")
            let decoded = try JSONDecoder().decode(MoodVerses.self, from: data)
            print("✅ Decoded mood:", decoded.mood)
            return decoded
        } catch {
            print("❌ Error decoding \(fileName).json:", error)
            return nil
        }
    }
}

