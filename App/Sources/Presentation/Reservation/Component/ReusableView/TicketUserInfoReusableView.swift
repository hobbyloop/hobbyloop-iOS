//
//  TicketUserInfoReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/11.
//

import UIKit


import HPCommonUI
import Then
import SnapKit


public final class TicketUserInfoReusableView: UICollectionReusableView {
    
    private let userInfoImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.myOutlined.image
    }
    
    
    private let userInfoTitleLabel: UILabel = UILabel().then {
        $0.text = "예약자 정보"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
    }
    
    private let userInfoNoticeLabel: UILabel = UILabel().then {
        $0.text = "정보는 마이페이지에서 수정 가능해요"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray.color
        $0.textAlignment = .left
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [userInfoImageView, userInfoTitleLabel, userInfoNoticeLabel].forEach {
            self.addSubview($0)
        }
        
        userInfoImageView.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.top.equalToSuperview().offset(17)
            $0.left.equalToSuperview().offset(16)
        }
        
        userInfoTitleLabel.snp.makeConstraints {
            $0.left.equalTo(userInfoImageView.snp.right).offset(6)
            $0.height.equalTo(19)
            $0.centerY.equalTo(userInfoImageView)
        }
        
        userInfoNoticeLabel.snp.makeConstraints {
            $0.left.equalTo(userInfoTitleLabel.snp.right).offset(8)
            $0.height.equalTo(14)
            $0.centerY.equalTo(userInfoTitleLabel)
        }
    }
    
}
