//
//  UIButton+.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/02.
//

import UIKit
import HPCommonUI

extension MyPageViewController {
    /// 이미지와 텍스트가 세로 방향으로 나열된 버튼 반환.
    func verticalStackButton(imageView: UIImageView, label: UILabel, topMargin: CGFloat = 0) -> UIButton {
        let button = UIButton(type: .custom)
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        button.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(37)
            $0.height.equalTo(51)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.top).offset(topMargin)
            $0.centerX.equalTo(button.snp.centerX)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(button.snp.leading)
            $0.trailing.equalTo(button.snp.trailing)
            $0.bottom.equalTo(button.snp.bottom)
        }
        
        return button
    }
    
    /// 이미지, 설명 텍스트, 개수 텍스트가 가로로 나열된 버튼 반환.
    func horizontalStackButton(imageView: UIImageView, description: String, countLabel: UILabel) -> UIButton {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        descriptionLabel.textColor = HPCommonUIAsset.couponInfoLabel.color
        
        
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 5
        
        [imageView, descriptionLabel, countLabel].forEach(contentStack.addArrangedSubview(_:))
        
        button.addSubview(contentStack)
        
        contentStack.snp.makeConstraints {
            $0.top.equalTo(button.snp.top)
            $0.leading.equalTo(button.snp.leading)
            $0.trailing.equalTo(button.snp.trailing)
            $0.bottom.equalTo(button.snp.bottom)
        }
        
        return button
    }
}
