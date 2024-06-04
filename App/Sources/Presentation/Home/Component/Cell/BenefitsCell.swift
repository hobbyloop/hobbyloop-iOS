//
//  BenefitsCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/25.
//

import UIKit

import HPCommonUI
import Then
import SnapKit



public final class BenefitsCell: UICollectionViewCell {
    
    
    private let benefitsCotentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .brown
    }
    
    private let benefitsPageCountView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.white.color.withAlphaComponent(0.2)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let benefitsPageCountLable: UILabel = UILabel().then {
        $0.text = "0/0"
        $0.textColor = HPCommonUIAsset.white.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 10)
        $0.textAlignment = .center
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        benefitsPageCountView.addSubview(benefitsPageCountLable)
        
        [benefitsCotentImageView, benefitsPageCountView].forEach {
            self.contentView.addSubview($0)
        }
        
        benefitsCotentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        benefitsPageCountView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(27)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(36)
            $0.height.equalTo(16)
        }
        
        benefitsPageCountLable.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(10)
            $0.center.equalToSuperview()
        }

        
    }
    
}


