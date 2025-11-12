//
//  HomeScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 06/10/2025.
//

import UIKit

//class HomeScreenViewController: UIViewController {
//    var viewModel: HomeScreenViewModel
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Verse of the Day"
//        label.font = UIFont(name: "PTSerif-Bold", size: 25)
//        label.textColor = UIColor(named: "Forest")
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let verseCard: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 10
//        view.layer.shadowOpacity = 0.05
//        view.layer.shadowRadius = 5
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 3)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//  }()
//
//   private let arabicVerseLabel: UILabel = {
//        let label = UILabel()
//       label.font = UIFont(name: "PTSerif-Bold", size: 30)
//       label.text = "إِنَّ مَعَ الْعُسْرِ يُسْرًا"
//       label.adjustsFontForContentSizeCategory = true
//       label.adjustsFontSizeToFitWidth = true
//       label.lineBreakMode = .byWordWrapping
//       label.textColor = UIColor(named: "Forest")
//       label.textAlignment = .center
//       label.numberOfLines = 0
//       label.translatesAutoresizingMaskIntoConstraints = false
//       return label
//  }()
//
//    private let englishVerseLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "PTSerif-Bold", size: 20)
//        label.text = "Indeed, with hardship comes ease."
//        label.lineBreakMode = .byWordWrapping
//        label.adjustsFontForContentSizeCategory = true
//        label.adjustsFontSizeToFitWidth = true
//        label.textColor = UIColor(named: "Forest")
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let categoriesList: UIStackView = {
//        let categories = [
//                ("Fear", "😟"),
//                ("Patience", "⏳"),
//                ("Hope", "🌅"),
//                ("Forgiveness", "✋"),
//                ("Gratitude", "🌙"),
//                ("Forbearance", "◐")
//        ]
//
//        let buttons = categories.map{title, emoji in return CategoriesButton(title: title, emoji: emoji)}
//
//       //MARK: - CREATING THE VERTICAL STACKS
//        let grid = UIStackView()
//        grid.axis = .vertical
//        grid.distribution = .fillEqually
//        grid.spacing = 16
//        grid.translatesAutoresizingMaskIntoConstraints = false
//
//        //MARK: - CREATING THE HORIZONTAL BUTTONROW STACKS
//        for row in stride(from: 0, to: buttons.count, by: 2) {
//            let rowStack = UIStackView(arrangedSubviews: Array(buttons[row..<min(row+2, buttons.count)]))
//            rowStack.axis = .horizontal
//            rowStack.distribution = .fillEqually
//            rowStack.spacing = 16
//            grid.addArrangedSubview(rowStack)
//        }
//        return grid
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUp()
//        view.layoutIfNeeded()
//        wireButtonsAction()
//}
//
//    init(viewModel: HomeScreenViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setUp() {
//        view.backgroundColor = UIColor(named: "Cream")
//        view.addSubview(titleLabel)
//        view.addSubview(verseCard)
//        verseCard.addSubview(arabicVerseLabel)
//        verseCard.addSubview(englishVerseLabel)
//        view.addSubview(categoriesList)
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            verseCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            verseCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            verseCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            //             verseCard.bottomAnchor.constraint(equalTo: englishVerseLabel.bottomAnchor, constant: 20),
//            verseCard.heightAnchor.constraint(equalToConstant: 140),
//
//            arabicVerseLabel.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 5),
//            arabicVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 1),
//            arabicVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -10),
//            arabicVerseLabel.heightAnchor.constraint(equalTo: verseCard.heightAnchor, multiplier: 0.50),
//
//            englishVerseLabel.topAnchor.constraint(equalTo: arabicVerseLabel.bottomAnchor, constant: 5),
//            englishVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 5),
//            englishVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -5),
//            englishVerseLabel.bottomAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: -10),
//
//            categoriesList.topAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: 20),
//            categoriesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            categoriesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            categoriesList.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
//
//        ])
//    }
//
//    private func wireButtonsAction(){
//        for case let rowStack as UIStackView in categoriesList.arrangedSubviews {
//            for case let button as CategoriesButton in rowStack.arrangedSubviews{
//                button.onTap = { [weak self] in
//                    print("Button Tapped: \(button.titleLabel?.text ?? "No Title")")
//                    let title = button.titleLabel?.text?.components(separatedBy: "\n").last
//                    self?.viewModel.loadVerses(for: title ?? "", completion: {})
//                }
//            }
//        }
//    }
//
//}

//
//  Enhanced HomeScreenViewController.swift
//  DailyAyah
//
//  Updated to show dynamic Verse of the Day with loading states
//

import UIKit

class HomeScreenViewController: UIViewController {
    var viewModel: HomeScreenViewModel

    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = UIColor(named: "Forest")
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: config), for: .normal)
        button.tintColor = UIColor(named: "Forest")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Your Mood"
        label.font = UIFont(name: "PTSerif-Bold", size: 22)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
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
            ("Forbearance", "⚪")
        ]

        let buttons = categories.map { title, emoji in
            return CategoriesButton(title: title, emoji: emoji)
        }

        let grid = UIStackView()
        grid.axis = .vertical
        grid.distribution = .fillEqually
        grid.spacing = 16
        grid.translatesAutoresizingMaskIntoConstraints = false

        for row in stride(from: 0, to: buttons.count, by: 2) {
            let rowStack = UIStackView(arrangedSubviews: Array(buttons[row..<min(row+2, buttons.count)]))
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 16
            grid.addArrangedSubview(rowStack)
        }
        return grid
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupBindings()
        wireButtonsAction()

        // Load verse of the day
        viewModel.loadVerseOfTheDay()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Check if we need to update the daily verse
        if MoodTracker.shouldUpdateDailyVerse() {
            viewModel.loadVerseOfTheDay()
        }
    }

    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setUp() {
        view.backgroundColor = UIColor(named: "Cream")

        // Add scroll view
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Add subviews to content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(verseCard)
        verseCard.addSubview(arabicVerseLabel)
        verseCard.addSubview(englishVerseLabel)
        verseCard.addSubview(loadingIndicator)
        verseCard.addSubview(refreshButton)
        contentView.addSubview(moodLabel)
        contentView.addSubview(categoriesList)

        // Refresh button action
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Verse card
            verseCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            verseCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            verseCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            verseCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 140),

            // Loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: verseCard.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: verseCard.centerYAnchor),

            // Refresh button
            refreshButton.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 8),
            refreshButton.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -8),
            refreshButton.widthAnchor.constraint(equalToConstant: 32),
            refreshButton.heightAnchor.constraint(equalToConstant: 32),

            // Arabic verse
            arabicVerseLabel.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 15),
            arabicVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 10),
            arabicVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -10),

            // English verse
            englishVerseLabel.topAnchor.constraint(equalTo: arabicVerseLabel.bottomAnchor, constant: 10),
            englishVerseLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 10),
            englishVerseLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -10),
            englishVerseLabel.bottomAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: -15),

            // Mood label
            moodLabel.topAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: 30),
            moodLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            moodLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Categories
            categoriesList.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 15),
            categoriesList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoriesList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categoriesList.heightAnchor.constraint(equalToConstant: 280),
            categoriesList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onDailyVerseLoaded = { [weak self] verse in
            self?.updateVerseCard(with: verse)
        }

        viewModel.onError = { [weak self] message in
            self?.showError(message)
        }
    }

    // MARK: - Actions
    @objc private func refreshTapped() {
        loadingIndicator.startAnimating()
        arabicVerseLabel.alpha = 0.3
        englishVerseLabel.alpha = 0.3

        viewModel.refreshDailyVerse()

        // Haptic feedback
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    private func wireButtonsAction() {
        for case let rowStack as UIStackView in categoriesList.arrangedSubviews {
            for case let button as CategoriesButton in rowStack.arrangedSubviews {
                button.onTap = { [weak self] in
                    let title = button.titleLabel?.text?.components(separatedBy: "\n").last
                    self?.viewModel.loadVerses(for: title ?? "", completion: {})

                    // Haptic feedback
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }
        }
    }

    // MARK: - UI Updates
    private func updateVerseCard(with verse: Verse) {
        loadingIndicator.stopAnimating()

        UIView.animate(withDuration: 0.3) {
            self.arabicVerseLabel.text = verse.arabicText
            self.englishVerseLabel.text = verse.translationText
            self.arabicVerseLabel.alpha = 1.0
            self.englishVerseLabel.alpha = 1.0
        }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
