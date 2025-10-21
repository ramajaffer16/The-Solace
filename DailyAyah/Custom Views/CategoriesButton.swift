//
//  CategoriesButton.swift
//  DailyAyah
//
//  Created by Ramadhan on 07/10/2025.
//

import UIKit

class CategoriesButton: UIButton {
    var onTap: (() -> Void)?

    override init (frame:CGRect){
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor = UIColor.systemBackground, title: String, emoji: String){
        super.init(frame: .zero)
        self.setTitle("\(emoji)\n\(title)", for: .normal)
        setup()
  }

    private func setup(){
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTitleColor(UIColor(named: "Forest"), for: .normal)
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.systemBackground.cgColor
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        titleLabel?.font = UIFont(name: "PTSerif-Regular", size: 15)
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }

    @objc private func buttonTapped(){
        onTap?()
    }

}
