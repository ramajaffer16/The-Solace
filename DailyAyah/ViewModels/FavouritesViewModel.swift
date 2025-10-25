//
//  FavouritesViewModel.swift
//  DailyAyah
//
//  Created by Ramadhan on 25/10/2025.
//

final class FavouritesViewModel {
    private(set) var favourites: [FavouriteAyah] = [] {
        didSet { onFavouritesChanged?(favourites) }
    }

    var onFavouritesChanged: (([FavouriteAyah]) -> Void)?

    func loadFavourites() {
        favourites = FavouritesStorage.load()
    }

    func removeFavourite(_ ayah: FavouriteAyah) {
        FavouritesStorage.remove(ayah)
        favourites = FavouritesStorage.load()
    }
}
