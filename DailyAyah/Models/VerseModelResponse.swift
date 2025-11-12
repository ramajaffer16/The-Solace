//
//  VerseModelResponse.swift
//  DailyAyah
//
//  Created by Ramadhan on 21/10/2025.
//

//struct VerseModelResponse: Codable {
//    let code: Int
//    let status: String
//    let data: [VerseModel]
//}
//
//struct VerseModel: Codable {
//    let text: String
//    let edition: Edition
//}
//
//struct Edition: Codable {
//    let identifier: String
//    let language: String
//}

//
//  VerseAPIResponse.swift
//  DailyAyah
//
//  API response models for alquran.cloud API
//

import Foundation

// MARK: - API Response Structure
struct VerseModelResponse: Codable {
    let code: Int
    let status: String
    let data: [VerseData]
}

struct VerseData: Codable {
    let number: Int
    let text: String
    let edition: Edition
    let surah: SurahInfo
    let numberInSurah: Int
    let juz: Int
    let manzil: Int
    let page: Int
    let ruku: Int
    let hizbQuarter: Int
    let sajda: SajdaInfo?

    // Custom decoding to handle sajda being either false or an object
    enum CodingKeys: String, CodingKey {
        case number, text, edition, surah, numberInSurah, juz, manzil, page, ruku, hizbQuarter, sajda
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        number = try container.decode(Int.self, forKey: .number)
        text = try container.decode(String.self, forKey: .text)
        edition = try container.decode(Edition.self, forKey: .edition)
        surah = try container.decode(SurahInfo.self, forKey: .surah)
        numberInSurah = try container.decode(Int.self, forKey: .numberInSurah)
        juz = try container.decode(Int.self, forKey: .juz)
        manzil = try container.decode(Int.self, forKey: .manzil)
        page = try container.decode(Int.self, forKey: .page)
        ruku = try container.decode(Int.self, forKey: .ruku)
        hizbQuarter = try container.decode(Int.self, forKey: .hizbQuarter)

        // Handle sajda being either false (bool) or an object
        if let sajdaObject = try? container.decode(SajdaInfo.self, forKey: .sajda) {
            sajda = sajdaObject
        } else {
            sajda = nil // If it's false or missing, set to nil
        }
    }
}

struct Edition: Codable {
    let identifier: String
    let language: String
    let name: String
    let englishName: String
    let format: String
    let type: String
    let direction: String?
}

struct SurahInfo: Codable {
    let number: Int
    let name: String
    let englishName: String
    let englishNameTranslation: String
    let numberOfAyahs: Int
    let revelationType: String
}

struct SajdaInfo: Codable {
    let id: Int
    let recommended: Bool
    let obligatory: Bool
}
