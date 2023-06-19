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
    private let containerView: UIView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = HPCommonUIAsset.separator.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
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
        configure()
    }
    
    
    //MARK: Configure
    private func configure() {
        containerView.addSubview(datePickerView)
        view.addSubview(containerView)
        
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
}
