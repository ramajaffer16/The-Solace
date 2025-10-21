//
//  VerseDetailVC.swift
//  DailyAyah
//
//  Created by Ramadhan on 11/10/2025.
//

import UIKit

class VerseDetailViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Verse Detail"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let verseCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cream") ?? UIColor.systemBackground
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let arabicVerseLabel: UILabel = {
        let label = UILabel()
        label.text = "وَمَا كَانَ اللّٰهُ لِيُضِيعَ إِيمَانَكُمْ إِنَّ اللّٰهَ بِالنَّاسِ لَرَءُوفٌ رَّحِيمٌ"
        label.font = UIFont(name: "PTSerif-Regular", size: 32)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let translationLabel: UILabel = {
        let label = UILabel()
        label.text = "But Allah would not let your faith go to waste; for Allah is kind and merciful to the people."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let reflectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reflection"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "Forest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let reflectionBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "In times of difficulty, we may feel as though our faith is being tested. This verse reminds us that Allah does not let our efforts go in vain. He is always kind and merciful to us, even when we struggle."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "Forest")?.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mark as Favorite", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Forest")
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background") ?? UIColor.systemBackground
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(verseCardView)
        verseCardView.addSubview(arabicVerseLabel)
        verseCardView.addSubview(translationLabel)
        view.addSubview(reflectionTitleLabel)
        view.addSubview(reflectionBodyLabel)
        view.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            verseCardView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            verseCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            verseCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            arabicVerseLabel.topAnchor.constraint(equalTo: verseCardView.topAnchor, constant: 24),
            arabicVerseLabel.leadingAnchor.constraint(equalTo: verseCardView.leadingAnchor, constant: 16),
            arabicVerseLabel.trailingAnchor.constraint(equalTo: verseCardView.trailingAnchor, constant: -16),

            translationLabel.topAnchor.constraint(equalToSystemSpacingBelow: arabicVerseLabel.bottomAnchor, multiplier: 2),
            translationLabel.leadingAnchor.constraint(equalTo: verseCardView.leadingAnchor, constant: 16),
            translationLabel.trailingAnchor.constraint(equalTo: verseCardView.trailingAnchor, constant: -16),
            translationLabel.bottomAnchor.constraint(equalTo: verseCardView.bottomAnchor, constant: -24),

            reflectionTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: verseCardView.bottomAnchor, multiplier: 3),
            reflectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            reflectionBodyLabel.topAnchor.constraint(equalToSystemSpacingBelow: reflectionTitleLabel.bottomAnchor, multiplier: 1),
            reflectionBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            reflectionBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            favoriteButton.topAnchor.constraint(equalToSystemSpacingBelow: reflectionBodyLabel.bottomAnchor, multiplier: 4),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
