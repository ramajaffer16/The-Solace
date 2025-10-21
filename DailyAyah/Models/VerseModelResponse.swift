//
//  VerseModelResponse.swift
//  DailyAyah
//
//  Created by Ramadhan on 21/10/2025.
//

struct VerseModelResponse: Codable {
    let data: [VerseModel]
}

struct VerseModel: Codable {
    let text: String
    let edition: Edition
}

struct Edition: Codable {
    let identifier: String
    let language: String
}
