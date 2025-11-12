//
//  ProtocolManagers.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//

protocol NetworkManaging {
    func fetchVerses(for moodData: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void)
}

protocol localDataManaging {
    func loadMoodVerses(from fileName: String) -> MoodVerses?
}
