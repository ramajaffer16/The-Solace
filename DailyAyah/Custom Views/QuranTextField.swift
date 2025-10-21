//
//  QuranTextField.swift
//  DailyAyah
//
//  Created by Ramadhan on 27/09/2025.
//

import UIKit

class QuranTextField: UITextField {

    override init (frame: CGRect){
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeholder: String? = nil, isSecureTextEntry: Bool = false, autoCapitalizationType: UITextAutocapitalizationType = .none) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        self.autocapitalizationType = autoCapitalizationType
    }

    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = (UIColor(named: "Forest") ?? UIColor.systemGreen).cgColor

        textColor = .label
        borderStyle = .roundedRect
        font = UIFont.preferredFont(forTextStyle: .body)
        tintColor = (UIColor(named: "Forest") ?? UIColor.systemGreen)
        textAlignment = .left
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)

        clearButtonMode = .whileEditing
        autocorrectionType = .no
        returnKeyType = .done
        translatesAutoresizingMaskIntoConstraints = false
    }

}
