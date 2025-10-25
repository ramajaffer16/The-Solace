//
//  VerseListCell.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//
//MARK: GET TO STUDY THIS CODE

import UIKit
final class VerseTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private let arabicLabel = UILabel()
    private let translationLabel = UILabel()
    private let referenceLabel = UILabel()
    private let favouriteButton = UIButton(type: .system)
    private let cardView = UIView()

    // MARK: - State Properties
    private var isFavourite = false
    private var currentAyah: FavouriteAyah?

    // MARK: - Callback
    var onFavouriteTapped: (() -> Void)?

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with ayah: FavouriteAyah) {
        currentAyah = ayah
        arabicLabel.text = ayah.arabicText
        translationLabel.text = ayah.translation
        referenceLabel.text = ayah.reference

        isFavourite = FavouritesStorage.load().contains(ayah)
        updateFavouriteButton()
    }

    // MARK: - Actions
    @objc private func favouriteTapped() {
        guard let ayah = currentAyah else { return }

        if isFavourite {
            FavouritesStorage.remove(ayah)
        } else {
            FavouritesStorage.add(ayah)
        }

        isFavourite.toggle()
        updateFavouriteButton()
        onFavouriteTapped?()
    }

    private func updateFavouriteButton() {
        let imageName = isFavourite ? "heart.fill" : "heart"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Add button and other UI setup here
    }
}
