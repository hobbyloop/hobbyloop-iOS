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



final class BenefitsCell: UICollectionViewCell {
    
    
    private let benefitsCotentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .brown
    }
    
    private let benefitsPageViewControl: HPPageControl = HPPageControl().then {
        $0.numberOfPages = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        [benefitsCotentImageView, benefitsPageViewControl].forEach {
            self.contentView.addSubview($0)
        }
        
        benefitsCotentImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        benefitsPageViewControl.snp.makeConstraints {
            $0.top.equalTo(benefitsCotentImageView.snp.bottom).offset(20)
            $0.height.equalTo(8)
            $0.centerX.equalToSuperview()
        }
        
    }
    
}


