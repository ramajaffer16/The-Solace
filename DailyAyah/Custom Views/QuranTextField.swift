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

    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = (UIColor(named: "Primary Green") ?? UIColor.systemGreen).cgColor

       textColor = .label
       font = UIFont.preferredFont(forTextStyle: .body)
       tintColor = (UIColor(named: "Primary Green") ?? UIColor.systemGreen)
       textAlignment = .left
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0.95)

        placeholder = "Enter text..."
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        returnKeyType = .done
        translatesAutoresizingMaskIntoConstraints = false
    }

}
