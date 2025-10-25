//
//  VerseListCell.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//
//MARK: GET TO STUDY THIS CODE
import UIKit

final class VerseTableViewCell: UITableViewCell {
    private let arabicLabel = UILabel()
    private let translationLabel = UILabel()
    private let referenceLabel = UILabel()
    private let favouriteButton = UIButton(type: .system)
    private let cardView = UIView()

    // Callback to inform ViewModel or ViewController when tapped
    var onFavouriteTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with verse: Verse) {
        arabicLabel.text = verse.arabicText
        translationLabel.text = verse.translationText
        referenceLabel.text = "Surah \(verse.surahNumber):\(verse.ayahNumber)"
    }

    private func setupUI() {
        // Card background styling
        cardView.backgroundColor = UIColor(named: "Cream")
        cardView.layer.cornerRadius = 14
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        // Arabic verse styling
        arabicLabel.font = UIFont(name: "ScheherazadeNew-Bold", size: 26)
        arabicLabel.textAlignment = .center
        arabicLabel.numberOfLines = 0

        // English translation styling
        translationLabel.font = UIFont(name: "PTSerif-Regular", size: 17)
        translationLabel.textColor = UIColor(named: "Forest")
        translationLabel.textAlignment = .center
        translationLabel.numberOfLines = 0

        // Reference label styling
        referenceLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        referenceLabel.textColor = .gray
        referenceLabel.textAlignment = .left

        // Favourite button styling
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favouriteButton.tintColor = UIColor.systemRed
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)

        // Bottom row: Reference + Heart button
        let bottomRow = UIStackView(arrangedSubviews: [referenceLabel, favouriteButton])
        bottomRow.axis = .horizontal
        bottomRow.alignment = .center
        bottomRow.spacing = 6
        bottomRow.distribution = .fill
        bottomRow.translatesAutoresizingMaskIntoConstraints = false

        // Main vertical stack: Arabic, Translation, BottomRow
        let mainStack = UIStackView(arrangedSubviews: [arabicLabel, translationLabel, bottomRow])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        cardView.addSubview(mainStack)
        contentView.addSubview(cardView)

        // Layout constraints
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),

            favouriteButton.heightAnchor.constraint(equalToConstant: 22),
            favouriteButton.widthAnchor.constraint(equalToConstant: 22)
        ])
    }

    @objc private func favouriteTapped() {
        let isFilled = favouriteButton.imageView?.image == UIImage(systemName: "heart.fill")
        let imageName = isFilled ? "heart" : "heart.fill"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        onFavouriteTapped?()
    }
}
