//
//  Network Manager.swift
//  DailyAyah
//
//  Created by Ramadhan on 15/10/2025.
//
//MARK: - HAVE TO STUDY THIS CODE
import Foundation

    class NetworkManager {
        static let shared = NetworkManager()
        private init() {}

        private let baseURL = "https://api.alquran.cloud/v1"

        func fetchAyah(surah: Int, ayah: Int, completion: @escaping (Result<VerseModelResponse, Error>) -> Void) {
            let urlString = "\(baseURL)/ayah/\(surah):\(ayah)/editions/quran-simple,en.asad"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    let err = NSError(domain: "Network", code: 404, userInfo: [NSLocalizedDescriptionKey: "No Data"])
                    completion(.failure(err))
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode(VerseModelResponse.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

extension NetworkManager {
    func fetchVerses(for mood: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void) {
        var verses: [Verse] = []
        let group = DispatchGroup()
        var firstError: Error?

        for ref in mood.verses {
            group.enter()
            fetchAyah(surah: ref.surah, ayah: ref.ayah) { result in
                switch result {
                case .success(let response):
                    let verse = Verse(apiResponse: response, surah: ref.surah, ayah: ref.ayah)
                    verses.append(verse)
                case .failure(let error):
                    firstError = error
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                completion(.success(verses))
            }
        }
    }
}


