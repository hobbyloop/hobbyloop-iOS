//
//  HPNewButton.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/24/24.
//

import UIKit

/// 새로운 버전의 공통 컴포넌트 버튼
/// 4가지 style 중 하나 사용
/// 남, 여 버튼과 같이 여러 옵션들 중 선택하는 버튼의 경우 HPNewSelectButton 사용할 것.
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
    
    public init(title: String, style: Style) {
        self.style = style
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
