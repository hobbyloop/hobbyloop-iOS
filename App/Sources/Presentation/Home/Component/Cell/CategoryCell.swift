//
//  CategoryCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 6/5/24.
//

import UIKit

import HPCommonUI

class CategoryCell: UICollectionViewCell {
    
    private let imageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.logo.image
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.text = "헬스/PT"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        [imageView, nameLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
