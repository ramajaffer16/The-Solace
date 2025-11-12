//
//  Network Manager.swift
//  DailyAyah
//
//  Created by Ramadhan on 15/10/2025.
//
//MARK: - HAVE TO STUDY THIS CODE
import Foundation

//class NetworkManager: NetworkManaging {
//        static let shared = NetworkManager()
//        private init() {}
//
//        private let baseURL = "https://api.alquran.cloud/v1"
//
//        func fetchAyah(surah: Int, ayah: Int, completion: @escaping (Result<VerseModelResponse, Error>) -> Void) {
//            let urlString = "\(baseURL)/ayah/\(surah):\(ayah)/editions/quran-simple,en.asad"
//            guard let url = URL(string: urlString) else { return }
//
//            URLSession.shared.dataTask(with: url) { data, _, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                guard let data = data else {
//                    let err = NSError(domain: "Network", code: 404, userInfo: [NSLocalizedDescriptionKey: "No Data"])
//                    completion(.failure(err))
//                    return
//                }
//                do {
//                    let decoded = try JSONDecoder().decode(VerseModelResponse.self, from: data)
//                    completion(.success(decoded))
//                } catch {
//                    completion(.failure(error))
//                }
//            }.resume()
//        }
//    }
//
//extension NetworkManager {
//    func fetchVerses(for mood: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void) {
//        var verses: [Verse] = []
//        let group = DispatchGroup()
//        var firstError: Error?
//
//        for ref in mood.verses {
//            group.enter()
//            fetchAyah(surah: ref.surah, ayah: ref.ayah) { result in
//                switch result {
//                case .success(let response):
//                    let reference: String = "Surah:\(ref.surah): Ayah:\(ref.ayah)"
//                    let verse = Verse(apiResponse: response, surahNumber: ref.surah, ayahNumber: ref.ayah, reference: reference)
//                    verses.append(verse)
//                case .failure(let error):
//                    firstError = error
//                }
//                group.leave()
//            }
//        }
//
//        group.notify(queue: .main) {
//            if let error = firstError {
//                completion(.failure(error))
//            } else {
//                completion(.success(verses))
//            }
//        }
//    }
//}
//
//  Enhanced NetworkManager.swift
//  DailyAyah
//
//  Network manager with caching support for offline access
//
import Foundation

class EnhancedNetworkManager: NetworkManaging {
    static let shared = EnhancedNetworkManager()
    private init() {}

    private let baseURL = "https://api.alquran.cloud/v1"

    // MARK: - Fetch Verses with Caching
    func fetchVerses(for mood: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void) {
        // Check cache first
        if let cachedVerses = CacheManager.getCachedVerses(forMood: mood.mood) {
            print("✅ Loaded \(cachedVerses.count) verses from cache for mood: \(mood.mood)")
            completion(.success(cachedVerses))
            return
        }

        // Not in cache, fetch from network
        print("🌐 Fetching verses from network for mood: \(mood.mood)")
        fetchVersesFromNetwork(for: mood) { result in
            switch result {
            case .success(let verses):
                // Cache the results
                CacheManager.cache(verses: verses, forMood: mood.mood)
                completion(.success(verses))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Fetch Single Ayah
    func fetchAyah(surah: Int, ayah: Int, completion: @escaping (Result<VerseModelResponse, Error>) -> Void) {
        // Check if specific verse is cached
        if let cachedVerse = CacheManager.getCachedVerse(surah: surah, ayah: ayah) {
            // Convert cached verse back to API response format
            // For simplicity, we'll still fetch from network for single ayahs
            // since they're typically used for verse of the day
        }

        let urlString = "\(baseURL)/ayah/\(surah):\(ayah)/editions/quran-simple,en.asad"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Network error:", error.localizedDescription)
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
                print("❌ Decoding error:", error)
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Private Network Fetch
    private func fetchVersesFromNetwork(for mood: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void) {
        var verses: [Verse] = []
        let group = DispatchGroup()
        var firstError: Error?

        for ref in mood.verses {
            group.enter()
            fetchAyah(surah: ref.surah, ayah: ref.ayah) { result in
                switch result {
                case .success(let response):
                    let reference = "Surah \(ref.surah):\(ref.ayah)"
                    let verse = Verse(
                        apiResponse: response,
                        surahNumber: ref.surah,
                        ayahNumber: ref.ayah,
                        reference: reference
                    )
                    verses.append(verse)

                case .failure(let error):
                    if firstError == nil {
                        firstError = error
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                print("✅ Fetched \(verses.count) verses for mood: \(mood.mood)")
                completion(.success(verses))
            }
        }
    }

    // MARK: - Force Refresh (bypass cache)
    func forceRefreshVerses(for mood: MoodVerses, completion: @escaping (Result<[Verse], Error>) -> Void) {
        // Clear cache for this mood
        CacheManager.clearMood(mood.mood)

        // Fetch fresh data
        fetchVersesFromNetwork(for: mood, completion: completion)
    }
}
