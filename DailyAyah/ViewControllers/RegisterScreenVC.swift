//
//  RegisterScreen.swift
//  DailyAyah
//
//  Created by Ramadhan on 09/10/2025.
//

import UIKit

class RegisterScreenViewController: UIViewController {
    var viewModel: RegisterScreenViewModel

       private let logoImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "Quran logo"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Get Started"
            label.font = UIFont(name: "PTSerif-Bold", size: 36)
            label.textColor = UIColor(named: "Forest") ?? .systemGreen
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Enter your email to create an account"
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = UIColor(named: "Forest") ?? .systemGreen
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email address"
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 12
            textField.layer.borderWidth = 0
            textField.textAlignment = .left
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
            textField.leftViewMode = .always
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()

        private let getStartedButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Get Started", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "Forest") ?? .systemGreen
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.layer.cornerRadius = 16
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private let loginLabel: UILabel = {
            let label = UILabel()
            let text = "Already have an account? Log in"
            let attributed = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: "Log in")
            attributed.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            label.attributedText = attributed
            label.textColor = UIColor(named: "Forest") ?? .systemGreen
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "CreamBackground") ?? UIColor(red: 1, green: 0.98, blue: 0.93, alpha: 1)
            view.addSubview(logoImageView)
            view.addSubview(titleLabel)
            view.addSubview(subtitleLabel)
            view.addSubview(emailTextField)
            view.addSubview(getStartedButton)
            view.addSubview(loginLabel)

            setupConstraints()
        }

    init (viewModel: RegisterScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                logoImageView.widthAnchor.constraint(equalToConstant: 120),
                logoImageView.heightAnchor.constraint(equalToConstant: 100),

                titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                emailTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
                emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                emailTextField.heightAnchor.constraint(equalToConstant: 52),

                getStartedButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
                getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                getStartedButton.heightAnchor.constraint(equalToConstant: 60),

                loginLabel.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 32),
                loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
