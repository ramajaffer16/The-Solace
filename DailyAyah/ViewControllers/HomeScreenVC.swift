//
//  HomeScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 06/10/2025.
//

import UIKit

class HomeScreenViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Verse of the Day"
        label.font = UIFont(name: "PTSerif-Bold", size: 25)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let verseCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cream")
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
  }()

   private let arabicVerseLabel: UILabel = {
        let label = UILabel()
       label.font = UIFont(name: "PTSerif-Regular", size: 20)
       label.textColor = UIColor(named: "Forest")
       label.textAlignment = .center
       label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
  }()

    private let englishVerseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PTSerif-Regular", size: 20)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let categoriesList: UIStackView = {
        let categories = [
            ("Fear", "😟"),
                ("Patience", "⏳"),
                ("Hope", "🌅"),
                ("Forgiveness", "✋"),
                ("Gratitude", "🌙"),
                ("Forbearance", "◐")
        ]

        let buttons = categories.map{title, emoji in return CategoriesButton(title: title, emoji: emoji)}

       //MARK: - CREATING THE VERTICAL STACKS
        let grid = UIStackView()
        grid.axis = .vertical
        grid.distribution = .fillEqually
        grid.spacing = 16

        //MARK: - CREATING THE HORIZONTAL BUTTONROW STACKS
        for row in stride(from: 0, to: buttons.count, by: 2) {
            let rowStack = UIStackView(arrangedSubviews: Array(buttons[row..<row+2]))
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 16
            grid.addArrangedSubview(rowStack)
        }
        return grid
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        view.addSubview(titleLabel)
        view.addSubview(verseCard)
        verseCard.addSubview(arabicVerseLabel)
        verseCard.addSubview(englishVerseLabel)
        view.addSubview(categoriesList)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            verseCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            verseCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verseCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verseCard.heightAnchor.constraint(equalToConstant: 200),

            arabicVerseLabel.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 5),
            arabicVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 5),
            arabicVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -5),

            englishVerseLabel.topAnchor.constraint(equalTo: arabicVerseLabel.bottomAnchor, constant: 5),
            englishVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 5),
            englishVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -5),

            categoriesList.topAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: 32),
            categoriesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
   }

}
