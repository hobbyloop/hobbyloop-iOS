//
//  SignUpInfoView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

import HPCommonUI
import Then
import SnapKit

public enum SignUpType: String {
    case name
    case nickname
    case birthDay
    case phone
    
    func setTitleLabelText() -> String {
        switch self {
        case .name: return "이름"
        case .nickname: return "닉네임"
        case .birthDay: return "출생년도"
        case .phone: return "전화번호"
        }
    }
    
    func setPlaceholderText() -> String {
        switch self {
        case .name: return "회원님의 이름을 적어주세요."
        case .nickname: return "자신만의 닉네임을 지어보세요!"
        case .birthDay: return "태어난 생년월일을 선택해주세요."
        case .phone: return "-를 제외한 번호를 입력해주세요."
        }
    }
}


public final class SignUpInfoView: UIView {
    
    
    //MARK: Property
    public private(set) var titleType: SignUpType
    
    public let titleLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .justified
    }
    
    public let textFiledView: UITextField = UITextField().then {
        $0.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.borderStyle = .none
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 8
    }
    
    public init(titleType: SignUpType) {
        self.titleType = titleType
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure() {
        textFiledView.placeholder = titleType.setPlaceholderText()
        titleLabel.text = titleType.setTitleLabelText()
        
        
        [titleLabel, textFiledView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(7)
            $0.top.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        textFiledView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        
    }
    
    
    
    
    
}
