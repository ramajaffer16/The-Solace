//
//  VerseListCell.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//
//MARK: GET TO STUDY THIS CODE

import UIKit
//final class VerseTableViewCell: UITableViewCell {
//
//    // MARK: - UI Elements
//    private let arabicLabel = UILabel()
//    private let translationLabel = UILabel()
//    private let referenceLabel = UILabel()
//    private let favouriteButton = UIButton(type: .system)
//    private let cardView = UIView()
//
//    // MARK: - State Properties
//    private var isFavourite = false
//    private var currentAyah: Verse?
//
//    // MARK: - Callback
//    var onFavouriteTapped: (() -> Void)?
//
//    // MARK: - Initializers
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Configuration
//    func configure(with ayah: Verse) {
//        currentAyah = ayah
//        arabicLabel.text = ayah.arabicText
//        translationLabel.text = ayah.translationText
////        referenceLabel.text = ayah.reference
//
//        isFavourite = FavouritesStorage.load().contains(ayah)
//        updateFavouriteButton()
//    }
//
//    // MARK: - Actions
//    @objc private func favouriteTapped() {
//        guard let ayah = currentAyah else { return }
//
//        if isFavourite {
//            FavouritesStorage.remove(ayah)
//        } else {
//            FavouritesStorage.add(ayah)
//        }
//
//        isFavourite.toggle()
//        updateFavouriteButton()
//        onFavouriteTapped?()
//    }
//
//    private func updateFavouriteButton() {
//        let imageName = isFavourite ? "heart.fill" : "heart"
//        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
//    }
//
//    // MARK: - Setup UI
//    private func setupUI() {
//        // Add button and other UI setup here
//    }
//}

import UIKit

enum Theme {
    static let forest = UIColor(named: "Forest")!
    static let cream = UIColor(named: "Cream")!

    // Fonts
    static func arabicFont(size: CGFloat) -> UIFont {
        return UIFont(name: "PTSerif-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func translationFont(size: CGFloat) -> UIFont {
        return UIFont(name: "PTSerif-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func referenceFont(size: CGFloat) -> UIFont {
        return UIFont(name: "PTSerif-Italic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }

    static let cardCornerRadius: CGFloat = 14
}


final class VerseTableViewCell: UITableViewCell {

    static let reuseIdentifier = "VerseCell"

    // MARK: - UI Elements
    private let cardView = UIView()
    private let arabicLabel = UILabel()
    private let translationLabel = UILabel()
    private let referenceLabel = UILabel()
    private let favouriteButton = UIButton(type: .system)

    // MARK: - State
    private var isFavourite = false
    private var currentAyah: Verse?

    // MARK: - Callback
    var onFavouriteTapped: ((Verse, Bool) -> Void)?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with ayah: Verse) {
        currentAyah = ayah
        arabicLabel.text = ayah.arabicText
        translationLabel.text = ayah.translationText
        referenceLabel.text = ayah.reference

        isFavourite = FavouritesStorage.load().contains(ayah)
        updateFavouriteButton()
    }

    // MARK: - Actions
    @objc private func favouriteTapped() {
        guard let ayah = currentAyah else { return }
        isFavourite.toggle()

        if isFavourite {
            FavouritesStorage.add(ayah)
        } else {
            FavouritesStorage.remove(ayah)
        }

        updateFavouriteButton()
        onFavouriteTapped?(ayah, isFavourite)

        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    private func updateFavouriteButton() {
        let imageName = isFavourite ? "heart.fill" : "heart"
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        favouriteButton.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)
        favouriteButton.tintColor = .systemRed
    }

    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = UIColor(named: "Cream")
        contentView.backgroundColor = .clear
        selectionStyle = .none

        // --- Card View ---
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = Theme.cardCornerRadius
        cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.addSubview(cardView)

        // --- Arabic Label ---
        arabicLabel.translatesAutoresizingMaskIntoConstraints = false
        arabicLabel.numberOfLines = 0
        arabicLabel.textAlignment = .right
        arabicLabel.font = Theme.arabicFont(size: 22)
        arabicLabel.semanticContentAttribute = .forceRightToLeft
        arabicLabel.textColor = Theme.forest
        cardView.addSubview(arabicLabel)

        // --- Translation Label ---
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        translationLabel.numberOfLines = 0
        translationLabel.textAlignment = .natural
        translationLabel.font = Theme.translationFont(size: 16)
        translationLabel.textColor = Theme.forest.withAlphaComponent(0.9)
        cardView.addSubview(translationLabel)

        // --- Reference Label ---
        referenceLabel.translatesAutoresizingMaskIntoConstraints = false
        referenceLabel.textAlignment = .right
        referenceLabel.font = Theme.referenceFont(size: 13)
        referenceLabel.textColor = Theme.forest.withAlphaComponent(0.7)
        cardView.addSubview(referenceLabel)

        // --- Favourite Button ---
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.tintColor = Theme.forest
        favouriteButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
        cardView.addSubview(favouriteButton)

        // --- Constraints ---
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            favouriteButton.bottomAnchor.constraint(equalToSystemSpacingBelow: cardView.bottomAnchor, multiplier: -2),
            favouriteButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            favouriteButton.widthAnchor.constraint(equalToConstant: 36),
            favouriteButton.heightAnchor.constraint(equalToConstant: 36),

            arabicLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 14),
            arabicLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            arabicLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            translationLabel.topAnchor.constraint(equalTo: arabicLabel.bottomAnchor, constant: 8),
            translationLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            translationLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            referenceLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 10),
            referenceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            referenceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }
}
