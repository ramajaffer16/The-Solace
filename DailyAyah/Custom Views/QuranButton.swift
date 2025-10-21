//
//  QuranButton.swift
//  DailyAyah
//
//  Created by Ramadhan on 27/09/2025.
//

import UIKit

class QuranButton: UIButton {
    var onTap: (() -> Void)?

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor = (UIColor(named: "PrimaryColor") ?? UIColor.systemGreen), title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func buttonTapped() {
        onTap?()
    }
}
