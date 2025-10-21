//
//  LoginScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 09/10/2025.
//

import UIKit

class LoginScreenViewController: UIViewController {
    var viewModel: LoginScreenVM
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Quran logo")) 
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back"
        label.font = UIFont(name: "PTSerif-Bold", size: 28)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in to continue your journey."
        label.font = UIFont(name: "PTSerif-Regular", size: 20)
        label.textColor = UIColor(named: "Forest")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email or Username"
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(UIColor(named: "Forest"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "Forest")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "Merriweather-Bold", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don’t have an account? Create one", for: .normal)
        button.setTitleColor(UIColor(named: "Forest"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PTSerif-Regular", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream") // same background
        setupLayout()

        // Actions
//        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    init(viewModel: LoginScreenVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailField.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailField.heightAnchor.constraint(equalToConstant: 44),

            passwordField.topAnchor.constraint(equalToSystemSpacingBelow: emailField.bottomAnchor, multiplier: 2),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 44),

            forgotPasswordButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordField.bottomAnchor, multiplier: 0.5),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),

            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: forgotPasswordButton.bottomAnchor, multiplier: 3),
            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            createAccountButton.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func goBack() {
        dismiss(animated: true)
    }

    @objc private func handleLogin() {
        viewModel.goToHomeScreen()
    }
}


