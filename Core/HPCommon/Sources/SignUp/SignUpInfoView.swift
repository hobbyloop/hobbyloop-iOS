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
    case name = "이름"
    case nickname = "닉네임"
    case birthDay = "출생년도"
    case phone = "전화번호"
    case authcode = "인증번호"
    
    func setTitleLabelText() -> String {
        switch self {
        case .name: return "이름 *"
        case .nickname: return "닉네임"
        case .birthDay: return "출생년도 *"
        case .phone: return "전화번호 인증*"
        case .authcode: return ""
        }
    }
    
    func setPlaceholderText() -> String {
        switch self {
        case .name: return "회원님의 이름을 적어주세요."
        case .nickname: return "자신만의 닉네임을 지어보세요!"
        case .birthDay: return "태어난 생년월일을 선택해주세요."
        case .phone: return "-를 제외한 번호를 입력해주세요."
        case .authcode: return "인증번호를 입력해주세요"
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
        
    private let rightImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.downarrow.image
        $0.contentMode = .scaleAspectFit
        $0.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    public lazy var textFieldView: UITextField = UITextField().then {
        $0.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.borderStyle = .none
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 8
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
    }
    
    
    public lazy var descriptionLabel: UILabel = UILabel().then {
        $0.textColor = HPCommonUIAsset.error.color
        $0.numberOfLines = 1
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textAlignment = .left
    }
    
    public init(titleType: SignUpType) {
        self.titleType = titleType
        super.init(frame: .zero)
        
        switch titleType {
        case .birthDay:
            configure()
            textFieldView.isUserInteractionEnabled = false
            textFieldView.setupRightImage(image: HPCommonUIAsset.downarrow.image)
        case .phone:
            configure()
            textFieldView.keyboardType = .numberPad
            textFieldView.textContentType = .oneTimeCode
        case .authcode:
            authConfigure()
        default:
            configure()
            textFieldView.isUserInteractionEnabled = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure() {
        textFieldView.attributedPlaceholder = NSAttributedString(string: titleType.setPlaceholderText(), attributes: [
            .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        ])
        titleLabel.text = titleType.setTitleLabelText()
        
        
        [titleLabel, textFieldView, descriptionLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(7)
            $0.top.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        textFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(textFieldView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0)
        }

        
    }
    
    public func updateSuccessLayout() {
        self.descriptionLabel.text = ""
        
        descriptionLabel.snp.remakeConstraints {
            $0.top.equalTo(textFieldView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0)
        }
    }
    
    
    public func updateErrorLayout(type: SignUpType) {
        
        self.descriptionLabel.text = "\(type.rawValue)을 다시 확인해주세요."
        descriptionLabel.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-11)
        }
        
        
    }
    
    private func authConfigure() {
        self.addSubview(textFieldView)
        
        textFieldView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
    }
}


// MARK: Extensions
public extension UITextField {
    func setupRightImage(image: UIImage){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 24, height: 24))
        imageView.image = image
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
}
