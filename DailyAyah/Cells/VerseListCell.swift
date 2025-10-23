//
//  VerseListCell.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//

import UIKit

final class VerseTableViewCell: UITableViewCell {
    private let arabicLabel = UILabel()
    private let translationLabel = UILabel()
    private let referenceLabel = UILabel()
    private let cardView = UIView()

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
        cardView.backgroundColor = UIColor(named: "Cream")
        cardView.layer.cornerRadius = 14
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        arabicLabel.font = UIFont(name: "ScheherazadeNew-Bold", size: 26)
        arabicLabel.textAlignment = .center
        arabicLabel.numberOfLines = 0

        translationLabel.font = UIFont(name: "PTSerif-Regular", size: 17)
        translationLabel.textColor = UIColor(named: "Forest")
        translationLabel.textAlignment = .center
        translationLabel.numberOfLines = 0

        referenceLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        referenceLabel.textColor = .gray
        referenceLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [arabicLabel, translationLabel, referenceLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(stack)
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            stack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
}
