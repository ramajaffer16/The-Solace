//
//  VerseModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 15/10/2025.
//

struct Verse: Codable, Equatable {
    let surahNumber: Int
    let ayahNumber: Int
    let arabicText: String
    let translationText: String
    let reference: String
}

extension Verse{
    init(apiResponse: VerseModelResponse, surahNumber: Int, ayahNumber: Int, reference: String){
        self.surahNumber = surahNumber
        self.ayahNumber = ayahNumber
        self.arabicText = apiResponse.data.first{$0.edition.language == "ar"}?.text ?? ""
        self.translationText = apiResponse.data.first{$0.edition.language == "en"}?.text ?? ""
        self.reference = reference
    }
}



