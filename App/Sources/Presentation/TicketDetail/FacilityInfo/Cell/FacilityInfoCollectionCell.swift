//
//  FacilityInfoCollectionCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/10.
//

import UIKit
import HPCommonUI

class FacilityInfoCollectionCell: UICollectionViewCell {
    private lazy var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 18
        }
    }()
    
    private lazy var separator: UIView = {
        return UIView().then {
            $0.backgroundColor = .black
        }
    }()
    
    private lazy var logoImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.hobbyloop.image.withRenderingMode(.alwaysOriginal)
            $0.snp.makeConstraints {
                $0.width.equalTo(60)
                $0.height.equalTo(45)
            }
        }
    }()
    
    private lazy var textLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
            $0.lineBreakStrategy = .hangulWordPriority
            $0.numberOfLines = 0
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.preferredMaxLayoutWidth = textLabel.frame.size.width
        super.layoutSubviews()
    }
    
    private func initLayout() {
        [mainStackView, separator].forEach {
            contentView.addSubview($0)
        }
        
        [logoImageView, textLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.trailing.bottom.equalTo(contentView)
        }
        
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.5)
        }
    }
    
    public func configure(_ text: String) {
        textLabel.text = text
    }
}
