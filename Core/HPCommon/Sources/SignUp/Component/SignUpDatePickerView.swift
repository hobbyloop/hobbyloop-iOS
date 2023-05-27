//
//  SignUpDatePickerView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/05/26.
//

import UIKit
import HPCommonUI



public final class SignUpDatePickerView: UIDatePicker {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.preferredDatePickerStyle = .wheels
        self.tintColor = .separator
        self.datePickerMode = .date
        self.locale = Locale(identifier: "ko-KR")
        self.timeZone = .autoupdatingCurrent
        self.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        _ = self.subviews.map { $0.setValue(HPCommonUIColors.Color.clear, forKey: "magnifierLineColor")}
    }
    
    
}



