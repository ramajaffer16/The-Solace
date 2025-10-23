//
//  VerseModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 15/10/2025.
//

struct Verse: Codable {
    let surahNumber: Int
    let ayahNumber: Int
    let arabicText: String
    let translationText: String
}

extension Verse{
    init(apiResponse: VerseModelResponse, surahNumber: Int, ayahNumber: Int){
        self.surahNumber = surahNumber
        self.ayahNumber = ayahNumber
        self.arabicText = apiResponse.data.first{$0.edition.language == "ar"}?.text ?? ""
        self.translationText = apiResponse.data.first{$0.edition.language == "en"}?.text ?? ""

    }
}



