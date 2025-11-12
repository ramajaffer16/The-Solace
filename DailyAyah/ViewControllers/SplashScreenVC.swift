//
//  SplashScreenVC.swift
//  DailyAyah
//
//  Created by Ramadhan on 14/10/2025.
//

import UIKit

import UIKit

class SplashViewController: UIViewController {
    let viewModel: SplashScreenViewModel

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Quran logo")) // your logo name
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let SolaceLabel: UILabel = {
        let label = UILabel()
        label.text = "Solace"
        label.font = UIFont(name: "PTSerif-Bold", size: 75)
        label.textColor = UIColor(named: "Forest")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

   init(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
       super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp(){
        view.backgroundColor = UIColor(named: "Cream")
        view.addSubview(logoImageView)
        view.addSubview(SolaceLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),

            SolaceLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            SolaceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            SolaceLabel.heightAnchor.constraint(equalToConstant: 50),
//            SolaceLabel.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Wait for 2 seconds before showing login
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {[weak self] in
            self?.viewModel.goToNextStartScreen()
        }
    }
}
