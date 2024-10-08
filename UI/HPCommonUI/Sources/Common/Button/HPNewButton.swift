//
//  HPNewButton.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/24/24.
//

import UIKit

/// 새로운 버전의 공통 컴포넌트 버튼
/// 4가지 style 중 하나 사용
/// isEnabled, isSelected 값만 변경하면 되도록 구현
public final class HPNewButton: UIButton {
    public enum Style {
        /// 배경색이 보라색인 버튼 스타일
        case primary
        /// 배경색이 회색인 버튼 스타일
        case secondary
        /// 하얀 배경에 보라색 경계선이 있는 버튼 스타일
        case bordered
        /// 할인 쿠폰 받기 버튼에 사용되는 버튼 스타일, 제목 왼쪽에 내려받기 이미지 존재
        case receive
    }
    
    let style: Style
    let unselectedTitleColor: UIColor
    
    public init(title: String, style: Style, unselectedTitleColor: UIColor = HPCommonUIAsset.gray60.color) {
        self.style = style
        self.unselectedTitleColor = unselectedTitleColor
        super.init(frame: .zero)
        self.layer.cornerRadius = 8
        self.setTitle(title, for: [])
        
        switch style {
        case .primary:
            self.backgroundColor = HPCommonUIAsset.primary.color
            self.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
            self.setTitleColor(.white, for: [])
        case .secondary:
            self.backgroundColor = HPCommonUIAsset.gray20.color
            self.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
            self.setTitleColor(HPCommonUIAsset.gray100.color, for: .normal)
            self.setTitleColor(.white, for: .disabled)
        case .bordered:
            self.backgroundColor = .white
            self.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
            self.layer.borderColor = HPCommonUIAsset.primary.color.cgColor
            self.layer.borderWidth = 1
            self.setTitleColor(HPCommonUIAsset.primary.color, for: .normal)
            self.setTitleColor(HPCommonUIAsset.gray60.color, for: .disabled)
        case .receive:
            self.backgroundColor = .white
            self.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
            self.layer.borderColor = HPCommonUIAsset.primary.color.cgColor
            self.layer.borderWidth = 1
            let image = HPCommonUIAsset.receive.image.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: [])
            self.tintColor = HPCommonUIAsset.primary.color
            self.setTitleColor(HPCommonUIAsset.primary.color, for: .normal)
            self.setTitleColor(HPCommonUIAsset.gray60.color, for: .disabled)
            
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                switch style {
                case .primary:
                    self.backgroundColor = HPCommonUIAsset.primary.color
                case .secondary:
                    self.backgroundColor = HPCommonUIAsset.gray20.color
                case .bordered:
                    self.layer.borderColor = HPCommonUIAsset.primary.color.cgColor
                case .receive:
                    self.layer.borderColor = HPCommonUIAsset.primary.color.cgColor
                    self.tintColor = HPCommonUIAsset.primary.color
                }
            } else {
                switch style {
                case .primary, .secondary:
                    self.backgroundColor = HPCommonUIAsset.gray60.color
                case .bordered:
                    self.layer.borderColor = HPCommonUIAsset.gray60.color.cgColor
                case .receive:
                    self.layer.borderColor = HPCommonUIAsset.gray60.color.cgColor
                    self.tintColor = HPCommonUIAsset.gray60.color
                }
            }
        }
    }
    
    /// bordered 스타일의 버튼에서만 사용 가능,
    /// 프로퍼티 값 변경 시 제목과 경계선 색이 변경됨
    public override var isSelected: Bool {
        didSet {
            if style == .bordered {
                let titleColor = isSelected ? HPCommonUIAsset.primary.color : unselectedTitleColor
                let borderColor = isSelected ? HPCommonUIAsset.primary.color : HPCommonUIAsset.gray40.color
                self.layer.borderColor = borderColor.cgColor
                self.setTitleColor(titleColor, for: [])
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
