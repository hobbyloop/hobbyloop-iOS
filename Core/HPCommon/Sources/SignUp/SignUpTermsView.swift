//
//  SignUpTermsView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/15.
//

import UIKit

import HPCommonUI
import SnapKit
import Then


public enum SignUpTermsType: Equatable {
    case all
    case receive
    case info
    case none
    
    func setTermsTitleLabel() -> String {
        switch self {
        case .all: return "전체 동의"
        case .receive: return "마케팅 수신 정보 동의 [선택]"
        case .info: return "마케팅 정보 수집 동의 [선택]"
        case .none: return ""
        }
    }
    
    func setTermsFontColor() -> UIFont {
        switch self {
        case .all: return HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        default: return HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        }
    }
    
    
}

//TODO: SignUpTerms Type을 통해 Selected 처리 -> Reactor 추가

public final class SignUpTermsView: UIView {
    
    // MARK: Property
    private let termsTitleLabel: UILabel = UILabel().then {
        $0.text = "약관 동의"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .left
    }
    
    private let termsUnderLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.separator.color
    }

    public let termsAllView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .all)
    
    public let termsReceiveView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .receive)
    
    public let termsInfoView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .info)
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    
    private func configure() {
        
        [termsTitleLabel, termsAllView, termsUnderLineView, termsReceiveView, termsInfoView].forEach {
            addSubview($0)
        }
        
        termsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(7)
            $0.height.equalTo(20)
            $0.width.equalTo(65)
        }
        
        termsAllView.snp.makeConstraints {
            $0.top.equalTo(termsTitleLabel.snp.bottom).offset(20)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        termsUnderLineView.snp.makeConstraints {
            $0.top.equalTo(termsAllView.snp.bottom).offset(15)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        termsReceiveView.snp.makeConstraints {
            $0.top.equalTo(termsUnderLineView.snp.bottom).offset(17)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        termsInfoView.snp.makeConstraints {
            $0.top.equalTo(termsReceiveView.snp.bottom).offset(8)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    
}


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
