//
//  SignUpBottomSheetView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/19.
//

import UIKit

import HPCommonUI
import Then
import SnapKit

public final class SignUpBottomSheetView: UIViewController {
    
    
    //MARK: Property
    private let datePickerView: UIDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.tintColor = .separator
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        _ = $0.subviews.map { $0.setValue(HPCommonUIColors.Color.clear, forKey: "magnifierLineColor") }
    }
    
    
    
    //MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Configure
    private func configure() {}
    
    
}
