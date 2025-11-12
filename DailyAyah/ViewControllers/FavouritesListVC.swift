//
//  FavouritesVC.swift
//  DailyAyah
//
//  Created by Ramadhan on 25/10/2025.
//

import UIKit

final class FavouritesViewController: UIViewController {

    private let tableView = UITableView()
    private let emptyStateLabel = UILabel()
    private let viewModel: FavouritesViewModel
    private var favourites: [Verse] = []

    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favourites = FavouritesStorage.load()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadFavourites()
    }

    private func setupUI() {
        title = "Favourites"
        view.backgroundColor = UIColor(named: "Cream")

        // Table view setup
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VerseTableViewCell.self, forCellReuseIdentifier: "VerseCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        // Empty state label
        emptyStateLabel.text = "No favourites yet 🌙\nAdd some verses you love."
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupBindings() {
        viewModel.onFavouritesChanged = { [weak self] favourites in
            guard let self else { return }
            self.emptyStateLabel.isHidden = !favourites.isEmpty
            self.tableView.reloadData()
        }
    }
}

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VerseCell", for: indexPath) as? VerseTableViewCell else {
            return UITableViewCell()
        }
        let ayah: Verse = viewModel.favourites[indexPath.row]
        cell.configure(with: ayah)
        cell.onFavouriteTapped = { [weak self] ayah, isFavourite in
            self?.viewModel.removeFavourite(ayah)
        }
        return cell
    }
}

