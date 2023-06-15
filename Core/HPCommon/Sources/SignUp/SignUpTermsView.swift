//
//  SignUpTermsView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/15.
//

import UIKit

import HPCommonUI
import HPFoundation
import SnapKit
import Then


public enum SignUpTermsType: Equatable {
    case all
    case receive
    case info
    case none
}

//TODO: SignUpTerms Type을 통해 Selected 처리 -> Reactor 추가

public final class SignUpTermsView: UIView {
    
    // MARK: Property
    private let termsTitleLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .left
    }
    
}


public final class SignUpTermsCheckBoxView: UIView {
    
    
    // MARK: Property
    
    public private(set) var checkBoxType: SignUpTermsType
    
    private let checkBoxButton: UIButton = UIButton(type: .custom).then {
        $0.backgroundColor = HPCommonUIAsset.lightBackground.color
        $0.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
        $0.setImage(UIImage(), for: .normal)
    }
    
    private let termsDescriptionLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let termsDetailLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.textAlignment = .justified
        $0.numberOfLines = 1
        $0.setUnderLineAttributed(
            targetString: "자세히",
            font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
            underlineColor: HPCommonUIAsset.originSeparator.color,
            textColor: HPCommonUIAsset.originSeparator.color
        )
    }
    
    
    public init(checkBoxType: SignUpTermsType) {
        self.checkBoxType = checkBoxType
        super.init(frame: .zero)
        configureUI(type: checkBoxType)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Configure
    private func configureUI(type: SignUpTermsType) {
        switch type {
            
        case .all:
            
            [checkBoxButton, termsDescriptionLabel].forEach {
                addSubview($0)
            }
            
        default:
            [checkBoxButton, termsDescriptionLabel, termsDetailLabel].forEach {
                addSubview($0)
            }
            
            
        }
    }

    
}
