//
//  DailyAyahWidget.swift
//  DailyAyahWidget
//
//  Created by Ramadhan on 12/11/2025.
//

//
//  DailyAyahWidget.swift
//  DailyAyahWidget
//
//  Widget showing Verse of the Day
//

import WidgetKit
import SwiftUI

// MARK: - Widget Entry
struct VerseEntry: TimelineEntry {
    let date: Date
    let verse: Verse?
    let mood: String
}

// MARK: - Widget Timeline Provider
struct VerseProvider: TimelineProvider {

    func placeholder(in context: Context) -> VerseEntry {
        VerseEntry(
            date: Date(),
            verse: createPlaceholderVerse(),
            mood: "Hope"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (VerseEntry) -> Void) {
        loadTodaysVerse { verse in
            let entry = VerseEntry(
                date: Date(),
                verse: verse ?? createPlaceholderVerse(),
                mood: VerseOfTheDayManager.getTodaysMood() ?? "Hope"
            )
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VerseEntry>) -> Void) {
        loadTodaysVerse { verse in
            let currentDate = Date()

            // Create entry for now
            let entry = VerseEntry(
                date: currentDate,
                verse: verse ?? createPlaceholderVerse(),
                mood: VerseOfTheDayManager.getTodaysMood() ?? "Hope"
            )

            // Schedule next update at midnight
            let midnight = Calendar.current.startOfDay(for: currentDate)
            let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!

            let timeline = Timeline(entries: [entry], policy: .after(nextMidnight))
            completion(timeline)
        }
    }

    // MARK: - Load Verse
    private func loadTodaysVerse(completion: @escaping (Verse?) -> Void) {
        // Try to load from saved daily verse
        if let data = SharedUserDefaults.shared.data(forKey: "verse_of_the_day"),
           let dailyVerse = try? JSONDecoder().decode(VerseOfTheDayManager.DailyVerse.self, from: data),
           Calendar.current.isDateInToday(dailyVerse.date) {
            completion(dailyVerse.verse)
            return
        }

        // Fallback to a cached verse from Hope
        if let cachedVerses = CacheManager.getCachedVerses(forMood: "Hope"),
           let firstVerse = cachedVerses.first {
            completion(firstVerse)
            return
        }

        // No verse available
        completion(nil)
    }

    private func createPlaceholderVerse() -> Verse {
        return Verse(
            surahNumber: 94,
            ayahNumber: 5,
            arabicText: "إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا",
            translationText: "Indeed, with hardship comes ease.",
            reference: "Surah 94:5"
        )
    }
}

// MARK: - Widget View
struct VerseWidgetView: View {
    var entry: VerseProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            // Background
            Color("Cream")
                .ignoresSafeArea()

            VStack(spacing: 8) {
                // Title
                Text("Verse of the Day")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Forest").opacity(0.7))

                if let verse = entry.verse {
                    // Arabic Text
                    Text(verse.arabicText)
                        .font(.system(size: family == .systemSmall ? 16 : 20, weight: .bold, design: .serif))
                        .foregroundColor(Color("Forest"))
                        .multilineTextAlignment(.center)
                        .lineLimit(family == .systemSmall ? 2 : 4)
                        .padding(.horizontal, 8)

                    // Translation
                    Text(verse.translationText)
                        .font(.system(size: family == .systemSmall ? 12 : 14, design: .serif))
                        .foregroundColor(Color("Forest").opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineLimit(family == .systemSmall ? 2 : 3)
                        .padding(.horizontal, 8)

                    Spacer()

                    // Reference
                    Text(verse.reference)
                        .font(.caption2)
                        .italic()
                        .foregroundColor(Color("Forest").opacity(0.6))
                } else {
                    Text("Open app to load today's verse")
                        .font(.caption)
                        .foregroundColor(Color("Forest").opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
    }
}

// MARK: - Widget Configuration
struct DailyAyahWidget: Widget {
    let kind: String = "DailyAyahWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VerseProvider()) { entry in
            VerseWidgetView(entry: entry)
        }
        .configurationDisplayName("Verse of the Day")
        .description("Daily Quranic verse based on your mood")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
struct DailyAyahWidget_Previews: PreviewProvider {
    static var previews: some View {
        VerseWidgetView(entry: VerseEntry(
            date: Date(),
            verse: Verse(
                surahNumber: 94,
                ayahNumber: 5,
                arabicText: "إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا",
                translationText: "Indeed, with hardship comes ease.",
                reference: "Surah 94:5"
            ),
            mood: "Hope"
        ))
        .previewContext(WidgetPreviewContext(family: .systemSmall))

        VerseWidgetView(entry: VerseEntry(
            date: Date(),
            verse: Verse(
                surahNumber: 94,
                ayahNumber: 5,
                arabicText: "إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا",
                translationText: "Indeed, with hardship comes ease.",
                reference: "Surah 94:5"
            ),
            mood: "Hope"
        ))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
