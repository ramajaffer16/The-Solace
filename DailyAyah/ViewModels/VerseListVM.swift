//
//  VerseListVM.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//

class VersesListViewModel {
   let coordinator: AppCoordinatorDelegate
    let verses: [Verse]

    init(coordinator: AppCoordinatorDelegate, verses: [Verse]) {
        self.coordinator = coordinator
        self.verses = verses
    }
}
