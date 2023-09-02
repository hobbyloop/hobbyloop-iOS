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
    
    func reviewCountText(_ count: Int) -> NSAttributedString {
        let newString = "리뷰 \(count)"
        let reviewRange = (newString as NSString).range(of: "리뷰 ")
        let countRange = (newString as NSString).range(of: "\(count)")
        
        let attributedString = NSMutableAttributedString(string: newString)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: reviewRange)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: countRange)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: countRange)
        
        return attributedString
    }
    
    func partHeaderButton(text: String) -> UIButton {
        let button = UIButton()
        
        let label = UILabel()
        label.text = text
        label.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        
        let arrowImageView = UIImageView(image: HPCommonUIAsset.rightarrow.image)
        arrowImageView.snp.makeConstraints {
            $0.width.equalTo(11)
            $0.height.equalTo(17)
        }
        
        [label, arrowImageView].forEach(button.addSubview(_:))
        
        label.snp.makeConstraints {
            $0.top.equalTo(button.snp.top)
            $0.bottom.equalTo(button.snp.bottom)
            $0.leading.equalTo(button.snp.leading).offset(29)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(button.snp.centerY)
            $0.trailing.equalTo(button.snp.trailing).offset(-27)
        }
        
        return button
    }
}
