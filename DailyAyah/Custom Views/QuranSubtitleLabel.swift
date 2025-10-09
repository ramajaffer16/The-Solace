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
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight = .regular){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        configure()
    }

    private func configure(){
        textColor = UIColor.secondaryLabel
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        translatesAutoresizingMaskIntoConstraints = false
    }

}
