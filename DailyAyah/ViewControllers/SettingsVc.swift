//
//  SettingsVc.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//  Settings and preferences screen
//

import UIKit

class SettingsViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // Settings sections
    private enum Section: Int, CaseIterable {
        case preferences
        case data
        case about

        var title: String {
            switch self {
            case .preferences: return "Preferences"
            case .data: return "Data"
            case .about: return "About"
            }
        }
    }

    private let preferenceOptions = ["Notifications", "Translation"]
    private let dataOptions = ["Clear Cache", "Reset Mood History"]
    private let aboutOptions = ["Version", "Privacy Policy", "Terms of Service"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Settings"
        view.backgroundColor = UIColor(named: "Cream")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = UIColor(named: "Cream")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }

        switch sectionType {
        case .preferences: return preferenceOptions.count
        case .data: return dataOptions.count
        case .about: return aboutOptions.count
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.font = UIFont(name: "PTSerif-Regular", size: 16)
        cell.textLabel?.textColor = UIColor(named: "Forest")

        guard let sectionType = Section(rawValue: indexPath.section) else { return cell }

        switch sectionType {
        case .preferences:
            cell.textLabel?.text = preferenceOptions[indexPath.row]
            cell.accessoryType = .disclosureIndicator

        case .data:
            cell.textLabel?.text = dataOptions[indexPath.row]
            cell.textLabel?.textColor = .systemRed
            cell.accessoryType = .none

        case .about:
            let option = aboutOptions[indexPath.row]
            cell.textLabel?.text = option

            if option == "Version" {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
                cell.detailTextLabel?.text = version
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        }

        return cell
    }
}

// MARK: - TableView Delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let sectionType = Section(rawValue: indexPath.section) else { return }

        switch sectionType {
        case .preferences:
            handlePreferenceSelection(at: indexPath.row)
        case .data:
            handleDataSelection(at: indexPath.row)
        case .about:
            handleAboutSelection(at: indexPath.row)
        }
    }

    private func handlePreferenceSelection(at row: Int) {
        switch row {
        case 0: // Notifications
            showComingSoon(feature: "Notifications")
        case 1: // Translation
            showComingSoon(feature: "Translation Selection")
        default:
            break
        }
    }

    private func handleDataSelection(at row: Int) {
        switch row {
        case 0: // Clear Cache
            showClearCacheConfirmation()
        case 1: // Reset Mood History
            showResetMoodHistoryConfirmation()
        default:
            break
        }
    }

    private func handleAboutSelection(at row: Int) {
        switch row {
        case 0: // Version
            break // Do nothing, it's just informational
        case 1: // Privacy Policy
            showComingSoon(feature: "Privacy Policy")
        case 2: // Terms of Service
            showComingSoon(feature: "Terms of Service")
        default:
            break
        }
    }

    // MARK: - Actions
    private func showClearCacheConfirmation() {
        let alert = UIAlertController(
            title: "Clear Cache",
            message: "This will clear all cached verses. They will be re-downloaded when needed.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { _ in
            CacheManager.clearAll()
            self.showSuccess(message: "Cache cleared successfully")
        })

        present(alert, animated: true)
    }

    private func showResetMoodHistoryConfirmation() {
        let alert = UIAlertController(
            title: "Reset Mood History",
            message: "This will reset your mood selection history. Your Verse of the Day will start fresh.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive) { _ in
            MoodTracker.reset()
            self.showSuccess(message: "Mood history reset successfully")
        })

        present(alert, animated: true)
    }

    private func showComingSoon(feature: String) {
        let alert = UIAlertController(
            title: "Coming Soon",
            message: "\(feature) will be available in a future update.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func showSuccess(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
