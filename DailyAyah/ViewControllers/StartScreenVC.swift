//
//  LoginScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 30/09/2025.
//

import UIKit

class StartScreenViewController: UIViewController {
    //MARK: - Public Variables
    let viewModel: StartScreenViewModel

    //MARK: - CREATE UI ELEMENTS
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Quran logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Solace"
        label.font = UIFont(name: "PTSerif-Bold", size: 70)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find peace in the\nwords of the Quran"
        label.font = UIFont(name: "PTSerif-Regular", size: 40)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont(name: "PTSerif-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "Forest")
        button.layer.cornerRadius = 14
        button.addTarget(StartScreenViewController.self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: "Forest"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PTSerif-Bold", size: 16)
        button.addTarget(StartScreenViewController.self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let bottomImageView: UIImageView = {
        let bottomImageView = UIImageView()
        bottomImageView.image = UIImage(named: "Pattern Image")
        bottomImageView.contentMode = .scaleAspectFill
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        return bottomImageView
    }()

    init(viewModel: StartScreenViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
 }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(named: "Cream")
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(getStartedButton)
        view.addSubview(loginButton)
        view.addSubview(bottomImageView)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5.0),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 12.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2.0),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            getStartedButton.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 4.0),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 150),
            getStartedButton.heightAnchor.constraint(equalToConstant: 40),

            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: getStartedButton.bottomAnchor, multiplier: 2.0),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: bottomImageView.topAnchor, constant: -50),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),

            bottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10)
        ])

    }

    //MARK: BUTTON ACTIONS
    @objc private func getStartedButtonTapped() {
        viewModel.getStartedButtonTapped()
    }

    @objc private func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
}

//colorhunt and uicolor.xyz

