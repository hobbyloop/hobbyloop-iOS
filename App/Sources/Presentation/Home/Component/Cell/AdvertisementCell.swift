//
//  AdvertisementCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2024/06/09.
//

import UIKit

import HPCommonUI
import Then


final class AdvertisementCell: UICollectionViewCell {
    
    //MARK: Property
    private let label: UILabel = UILabel().then {
        $0.text = "광고"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(label)
        
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
}
