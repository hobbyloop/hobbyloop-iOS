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

public final class ExerciseCell: UICollectionViewCell {
    
    //TODO: 추후 Data Bind Code 추가
    private let contentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .cyan
    }
    
    private let contentTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "필라피티 스튜디오"
    }
    
    private let contentLocationTitleLable: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "서울 강남구 압구정로50길 8 2층"
    }
    
    private let contentBookMarkButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.archiveOutlined.image, for: .normal)
        $0.setImage(HPCommonUIAsset.archiveFilled.image, for: .selected)
    }
    
    private let contentGradeImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = HPCommonUIAsset.starFilled.image
    }
    
    private let contentGradeLabel: UILabel = UILabel().then {
        $0.text = "0.0"
        $0.textColor = HPCommonUIAsset.shadowgray.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textAlignment = .left
        $0.numberOfLines = 1
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
        [contentImageView, contentTitleLabel, contentLocationTitleLable, contentGradeImageView ,contentGradeLabel,contentBookMarkButton].forEach {
            self.contentView.addSubview($0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(14)
            $0.left.equalToSuperview()
            $0.right.equalTo(contentBookMarkButton.snp.left).offset(-10)
            $0.height.equalTo(24)
        }
        
        contentBookMarkButton.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel)
            $0.right.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
        
        contentGradeLabel.snp.makeConstraints {
            $0.top.equalTo(contentBookMarkButton.snp.bottom).offset(9)
            $0.right.equalToSuperview().offset(-21)
            $0.width.equalTo(18)
            $0.height.equalTo(14)
        }
        
        contentGradeImageView.snp.makeConstraints {
            $0.width.height.equalTo(13)
            $0.right.equalTo(contentGradeLabel.snp.left).offset(-5)
            $0.centerY.equalTo(contentGradeLabel)
        }
        
        contentLocationTitleLable.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(8)
            $0.height.equalTo(15)
        }
        
    }
}
