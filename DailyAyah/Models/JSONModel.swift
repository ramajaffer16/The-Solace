//
//  JSONModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 21/10/2025.
//
struct MoodVerses: Codable {
    let mood: String
    let verses: [VerseReference]
}

struct VerseReference: Codable {
    let surah: Int
    let ayah: Int
}
