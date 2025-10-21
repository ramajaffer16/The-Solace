//
//  QuranSubtitleLabel.swift
//  DailyAyah
//
//  Created by Ramadhan on 28/09/2025.
//

import UIKit

class QuranSubtitleLabel: UILabel {

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment = .center,font: UIFont = UIFont(name: "PTSerif-Regular", size: 14) ?? .systemFont(ofSize: 14), textColor: UIColor = UIColor(named: "Forest") ?? .systemGreen, text: String){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = font
        self.text = text
        self.textColor = textColor
        configure()
    }

    private func configure(){
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
