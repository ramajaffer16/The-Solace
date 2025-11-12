//
//  DailyAyahWidgetBundle.swift
//  DailyAyahWidget
//
//  Created by Ramadhan on 12/11/2025.
//

import WidgetKit
import SwiftUI

@main
struct DailyAyahWidgetBundle: WidgetBundle {
    var body: some Widget {
        DailyAyahWidget()
        DailyAyahWidgetControl()
        DailyAyahWidgetLiveActivity()
    }
}
