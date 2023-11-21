//
//  FacilityInfoCollectionBusiness.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/09.
//

import UIKit
import HPCommonUI

class FacilityInfoCollectionBusiness: UICollectionViewCell {
    private lazy var mainStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    private lazy var businessTitleLabel: UILabel = UILabel().then {
        $0.text = "사업자 정보"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray6.color
        $0.lineBreakStrategy = .hangulWordPriority
        $0.numberOfLines = 0
    }
    
    private lazy var representativeStackView: BusinessStackView = BusinessStackView().then {
        $0.configure("대표자", "김하비")
    }
    
    private lazy var openingDateStackView: BusinessStackView = BusinessStackView().then {
        $0.configure("개업일자", "2023년 7월 19일")
    }
    
    private lazy var businessNumberStackView: BusinessStackView = BusinessStackView().then {
        $0.configure("사업장 번호", "123456789")
    }
    
    private lazy var mailOrderNumberStackView: BusinessStackView = BusinessStackView().then {
        $0.configure("통신판매 번호", "123456789")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func initLayout() {
        [businessTitleLabel, mainStackView].forEach {
            contentView.addSubview($0)
        }
        
        [representativeStackView, openingDateStackView, businessNumberStackView, mailOrderNumberStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        businessTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(17)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(businessTitleLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalTo(businessTitleLabel)
            $0.height.equalTo(78)
        }
    }
}
