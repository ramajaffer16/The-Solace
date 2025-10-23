//
//  VerseListVC.swift
//  DailyAyah
//
//  Created by Ramadhan on 23/10/2025.
//

import UIKit
final class VersesListViewController: UIViewController {
    private let viewModel: VersesListViewModel
    private let tableView = UITableView()

    init(viewModel: VersesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(VerseTableViewCell.self, forCellReuseIdentifier: "VerseCell")

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension VersesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.verses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VerseCell", for: indexPath) as? VerseTableViewCell else {
            return UITableViewCell()
        }
        let verse = viewModel.verses[indexPath.row]
        cell.configure(with: verse)
        return cell
    }
}
