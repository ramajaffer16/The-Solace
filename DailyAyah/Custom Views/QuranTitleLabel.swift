//
//  QuranTitleLabel.swift
//  DailyAyah
//
//  Created by Ramadhan on 27/09/2025.
//
import UIKit

// MARK: - Quran Title Label
class QuranTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight = .bold) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }

    private func configure() {
        textColor = UIColor(named: "Primary Green") ?? UIColor.systemGreen
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
