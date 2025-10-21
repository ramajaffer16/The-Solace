//
//  VerseModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 15/10/2025.
//

struct Verse: Codable {
    let surah: Int
    let ayah: Int
    let arabicText: String
    let translationText: String
}

extension Verse{
    init(apiResponse: VerseModelResponse, surah: Int, ayah: Int){
        self.surah = surah
        self.ayah = ayah
        self.arabicText = apiResponse.data.first{$0.edition.language == "ar"}?.text ?? ""
        self.translationText = apiResponse.data.first{$0.edition.language == "en"}?.text ?? ""

    }
}



