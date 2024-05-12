//
//  UIButton+.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/02.
//

import UIKit
import HPCommonUI

extension MyPageViewController {
    /// 포인트, 이용권, 리뷰 버튼에 해당
    func KeyValueButton(title: String, subtitle: String) -> UIButton {
        return UIButton(configuration: .plain()).then {
            $0.configuration?.attributedTitle = AttributedString.init(title, attributes: .init([
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: HPCommonUIAsset.gray80.color
            ]))
            
            $0.configuration?.attributedSubtitle = AttributedString.init(subtitle, attributes: .init([
                .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                .foregroundColor: HPCommonUIAsset.gray100.color
            ]))
            
            $0.configuration?.titleAlignment = .center
            $0.configuration?.titlePadding = 10
            $0.configuration?.contentInsets = .zero
        }
    }
    
    /// 보관함, 리뷰, 수업 내역 버튼에 해당
    func ArrowedButton(title: String, textColor: UIColor = HPCommonUIAsset.gray100.color) -> UIButton {
        let button = UIButton(configuration: .plain()).then {
            $0.configuration?.attributedTitle = AttributedString.init(title, attributes: .init([
                .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                .foregroundColor: textColor
            ]))
            
            
            $0.configuration?.imagePlacement = .trailing
            $0.configuration?.contentInsets = .init(top: 21, leading: 16, bottom: 22, trailing: 26)
            
            $0.configuration?.imagePadding = view.bounds.width - ($0.titleLabel?.intrinsicContentSize.width ?? 0) - 50
            $0.setImage(HPCommonUIAsset.rightarrow.image.withRenderingMode(.alwaysTemplate).imageWith(newSize: .init(width: 8, height: 14)), for: [])
            $0.tintColor = textColor
        }
        
        let bottomEdgeView = UIView()
        bottomEdgeView.backgroundColor = HPCommonUIAsset.gray20.color
        button.addSubview(bottomEdgeView)
        
        bottomEdgeView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        return button
    }
}
