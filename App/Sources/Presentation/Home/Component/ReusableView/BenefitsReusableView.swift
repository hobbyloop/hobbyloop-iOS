//
//  BenefitsReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/20.
//

import UIKit

import HPCommonUI
import HPExtensions
import Then

final class BenefitsReusableView: UICollectionReusableView {
    
    private let benefitsTitleLabel: UILabel = UILabel().then {
        $0.text = "오늘의 혜택"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.setSubScriptAttributed(
            targetString: "혜택",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18),
            color: HPCommonUIAsset.deepOrange.color
        )
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        self.addSubview(benefitsTitleLabel)
        
        benefitsTitleLabel.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
        }
    }
}


