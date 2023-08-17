//
//  FacilityInfoCollectionCompanyInfo.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/10.
//

import UIKit
import HPCommonUI

class FacilityInfoCollectionCompanyInfo: UICollectionViewCell {
    private lazy var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 26
        }
    }()
    
    private lazy var logoImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.hobbyloop.image.withRenderingMode(.alwaysOriginal)
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints {
                $0.height.width.equalTo(90)
            }
        }
    }()
    
    private lazy var textLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
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
        backgroundColor = .white
        
        [mainStackView].forEach {
            contentView.addSubview($0)
        }
        
        [logoImageView, textLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    public func configure(_ text: String) {
        textLabel.text = text
    }
}
