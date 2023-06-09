//
//  CouponCollectionCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/05.
//

import UIKit
import SnapKit

final class CouponCell: UICollectionViewCell {
    var coupon: DummyCoupon!
    static let identifier = "CouponCell"
    private lazy var couponView = CouponView(coupon: coupon)
        
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(couponView)
        configure()
    }
    
    private func configure() {
        couponView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
}
