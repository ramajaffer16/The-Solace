//
//  SharedUserDefaults.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//  Shared UserDefaults between app and widget
//

import Foundation

struct SharedUserDefaults {
    // IMPORTANT: Replace with your actual App Group identifier
    private static let appGroupID = "group.com.ramadhan.dailyayah"

    static var shared: UserDefaults {
        guard let userDefaults = UserDefaults(suiteName: appGroupID) else {
            fatalError("Unable to access App Group UserDefaults")
        }
        return userDefaults
    }
}
