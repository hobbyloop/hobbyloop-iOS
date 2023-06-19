//
//  SignUpTermsCheckBoxView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/19.
//

import UIKit

import HPCommonUI
import HPExtensions
import SnapKit
import Then


public final class SignUpTermsCheckBoxView: UIView {
    
    
    // MARK: Property
    
    public private(set) var checkBoxType: SignUpTermsType
    
    private let checkBoxButton: HPButton = HPButton(
        cornerRadius: 4,
        borderColor: HPCommonUIAsset.deepSeparator.color.cgColor
    ).then {
        $0.setImage(UIImage(), for: .normal)
        $0.backgroundColor = HPCommonUIAsset.lightBackground.color
    }
    
    private let termsDescriptionLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    public let termsDetailLabel: UILabel = UILabel().then {
        $0.text = "자세히"
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.textAlignment = .justified
        $0.numberOfLines = 1
        $0.setUnderLineAttributed(
            targetString: "자세히",
            font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
            underlineColor: HPCommonUIAsset.originSeparator.color,
            underlineStyle: .single,
            textColor: HPCommonUIAsset.originSeparator.color
        )
    }
    
    
    public init(checkBoxType: SignUpTermsType) {
        self.checkBoxType = checkBoxType
        super.init(frame: .zero)
        configureUI(type: checkBoxType)
        configureLayout(type: checkBoxType)
        
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
            
            checkBoxButton.snp.makeConstraints {
                $0.width.height.equalTo(24)
                $0.top.left.equalToSuperview()
            }
            
            termsDescriptionLabel.snp.makeConstraints {
                $0.centerY.equalTo(checkBoxButton)
                $0.height.equalTo(15)
                $0.left.equalTo(checkBoxButton.snp.right).offset(10)
            }
            
        default:
            
            [checkBoxButton, termsDescriptionLabel, termsDetailLabel].forEach {
                addSubview($0)
            }
            
            checkBoxButton.snp.makeConstraints {
                $0.width.height.equalTo(24)
                $0.top.left.equalToSuperview()
            }
            
            termsDescriptionLabel.snp.makeConstraints {
                $0.centerY.equalTo(checkBoxButton)
                $0.height.equalTo(15)
                $0.left.equalTo(checkBoxButton.snp.right).offset(10)
            }
            
            termsDetailLabel.snp.makeConstraints {
                $0.centerY.equalTo(termsDescriptionLabel)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(15)
                $0.width.equalTo(45)
            }
        }
    }
    
    
    private func configureLayout(type: SignUpTermsType) {
        
        switch type {
        case .all:
            termsDescriptionLabel.text = type.setTermsTitleLabel()
            termsDescriptionLabel.font = type.setTermsFontColor()
        case .receive:
            termsDescriptionLabel.text = type.setTermsTitleLabel()
            termsDescriptionLabel.font = type.setTermsFontColor()
        case .info:
            termsDescriptionLabel.text = type.setTermsTitleLabel()
            termsDescriptionLabel.font = type.setTermsFontColor()
        default:
            break
        }
    }

    
}
