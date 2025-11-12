//
//  FavouritesViewModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 25/10/2025.
//

final class FavouritesViewModel {
    var coordinator: AppCoordinatorDelegate
    private(set) var favourites: [Verse] = [] {
        didSet { onFavouritesChanged?(favourites) }
    }

    init (coordinator: AppCoordinatorDelegate) {
        self.coordinator = coordinator
    }

    var onFavouritesChanged: (([Verse]) -> Void)?

    func loadFavourites() {
        favourites = FavouritesStorage.load()
    }

    func removeFavourite(_ ayah: Verse) {
        FavouritesStorage.remove(ayah)
        favourites = FavouritesStorage.load()
    }
}
