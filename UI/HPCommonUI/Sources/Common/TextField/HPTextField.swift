//
//  HPTextField.swift
//  HPCommonUI
//
//  Created by 김남건 on 5/23/24.
//

import UIKit

/// 회원 가입, 내 정보 수정, 쿠폰 화면에서 사용되는 text field
public final class HPTextField: UITextField {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        self.textColor = HPCommonUIAsset.gray100.color
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 10))
        self.leftViewMode = .always
        self.rightView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 10))
        self.rightViewMode = .always
        self.layer.cornerRadius = 8
        self.layer.borderColor = HPCommonUIAsset.gray40.color.cgColor
        self.layer.borderWidth = 1
    }
    
    public var placeholderText: String? {
        get { self.attributedPlaceholder?.string }
        set {
            self.attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: [
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 16),
                .foregroundColor: HPCommonUIAsset.gray60.color
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
