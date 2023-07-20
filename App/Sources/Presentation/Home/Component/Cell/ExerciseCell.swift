//
//  ExerciseCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/19.
//

import UIKit

import HPCommonUI
import Then
import SnapKit

final class ExerciseCell: UICollectionViewCell {
    
    //TODO: 추후 Data Bind Code 추가
    private let contentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .cyan
    }
    
    private let contentTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "필라피티 스튜디오"
    }
    
    private let contentSubTitleLable: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "서울 강남구 압구정로50길 8 2층"
    }
    
    private let contentBookMarkButton: UIButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.archiveOutlined.image, for: .normal)
        $0.setImage(HPCommonUIAsset.archiveFilled.image, for: .selected)
        $0.setTitle("", for: .normal)
    }
    
    
    //MARK: Property
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        [contentImageView, contentTitleLabel, contentSubTitleLable, contentBookMarkButton].forEach {
            self.contentView.addSubview($0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(197)
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(14)
            $0.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        contentBookMarkButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.width.equalTo(24)
            $0.top.equalTo(contentTitleLabel)
        }
        
        contentSubTitleLable.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(9)
            $0.left.equalToSuperview()
            $0.height.equalTo(14)
        }
        
    }
}
