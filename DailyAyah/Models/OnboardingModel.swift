//
//  OnboardingModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//

import Foundation

struct OnboardingPage {
    let title: String
    let description: String
    let emoji: String
    let imageName: String?
}

extension OnboardingPage {
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to Daily Ayah",
            description: "Discover peace and guidance through personalized Quranic verses every day.",
            emoji: "🌙",
            imageName: nil
        ),
        OnboardingPage(
            title: "Choose Your Mood",
            description: "Select how you're feeling, and we'll show you relevant verses for comfort, hope, patience, and more.",
            emoji: "🎭",
            imageName: nil
        ),
        OnboardingPage(
            title: "Daily Inspiration",
            description: "Receive a personalized Verse of the Day based on your preferences. Add verses to favorites and access them anytime.",
            emoji: "✨",
            imageName: nil
        )
    ]
}
