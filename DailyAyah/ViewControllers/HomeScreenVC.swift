//
//  HomeScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 06/10/2025.
//

import UIKit

class HomeScreenViewController: UIViewController {
    var viewModel: HomeScreenViewModel

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
        view.backgroundColor = UIColor.white
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
       label.font = UIFont(name: "PTSerif-Bold", size: 30)
       label.text = "إِنَّ مَعَ الْعُسْرِ يُسْرًا"
       label.adjustsFontForContentSizeCategory = true
       label.adjustsFontSizeToFitWidth = true
       label.lineBreakMode = .byWordWrapping
       label.textColor = UIColor(named: "Forest")
       label.textAlignment = .center
       label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
  }()

    private let englishVerseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PTSerif-Bold", size: 20)
        label.text = "Indeed, with hardship comes ease."
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
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
        grid.translatesAutoresizingMaskIntoConstraints = false

        //MARK: - CREATING THE HORIZONTAL BUTTONROW STACKS
        for row in stride(from: 0, to: buttons.count, by: 2) {
            let rowStack = UIStackView(arrangedSubviews: Array(buttons[row..<min(row+2, buttons.count)]))
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
        view.layoutIfNeeded()
        wireButtonsAction()
}

    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        view.backgroundColor = UIColor(named: "Cream")
        view.addSubview(titleLabel)
        view.addSubview(verseCard)
        verseCard.addSubview(arabicVerseLabel)
        verseCard.addSubview(englishVerseLabel)
        view.addSubview(categoriesList)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            verseCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            verseCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verseCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //             verseCard.bottomAnchor.constraint(equalTo: englishVerseLabel.bottomAnchor, constant: 20),
            verseCard.heightAnchor.constraint(equalToConstant: 140),

            arabicVerseLabel.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 5),
            arabicVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 1),
            arabicVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -10),
            arabicVerseLabel.heightAnchor.constraint(equalTo: verseCard.heightAnchor, multiplier: 0.50),

            englishVerseLabel.topAnchor.constraint(equalTo: arabicVerseLabel.bottomAnchor, constant: 5),
            englishVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 5),
            englishVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -5),
            englishVerseLabel.bottomAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: -10),

            categoriesList.topAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: 20),
            categoriesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoriesList.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)

        ])
    }

    private func wireButtonsAction(){
        for case let rowStack as UIStackView in categoriesList.arrangedSubviews {
            for case let button as CategoriesButton in rowStack.arrangedSubviews{
                button.onTap = { [weak self] in
                    print("Button Tapped: \(button.titleLabel?.text ?? "No Title")")
                    let title = button.titleLabel?.text?.components(separatedBy: "\n").last
                    self?.viewModel.loadVerses(for: title ?? "", completion: {})
                }
            }
        }
    }

}
