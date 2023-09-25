//
//  CouponHistoryGroupItemView.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/02.
//

import UIKit
import HPCommonUI
import SnapKit

/// 각 구매 내역을 시설 및 이용권 이름별로 grouping하여 하나의 item으로 보여주는 view.
/// 마이페이지 화면의 이용권 구매내역 파트에서 사용
final class CouponPurchaseHistoryGroupItemView: UIView {
    private let logoImageView = UIImageView.circularImageView(radius: 25)
    private let studioNameLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
    }
    private let couponNameLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
        $0.textColor = HPCommonUIAsset.couponNameLabel.color
    }
    private let periodLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 11)
        $0.textColor = HPCommonUIAsset.couponPeriodLabel.color
    }
    
    init(logoImage: UIImage? = nil, studioName: String, couponName: String, periodString: String) {
        self.logoImageView.image = logoImage
        self.studioNameLabel.text = studioName
        self.couponNameLabel.text = couponName
        self.periodLabel.text = periodString
        
        super.init(frame: .zero)
        
        self.snp.makeConstraints {
            $0.height.equalTo(87)
        }
        
        [logoImageView, studioNameLabel, couponNameLabel, periodLabel].forEach(self.addSubview(_:))
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(19)
            $0.leading.equalTo(self.snp.leading).offset(11)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top).offset(5)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(14)
        }
        
        couponNameLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(studioNameLabel.snp.leading)
        }
        
        periodLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-7)
            $0.centerY.equalTo(studioNameLabel.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
