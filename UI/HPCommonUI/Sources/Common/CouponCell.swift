//
//  CouponCollectionCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/05.
//

import UIKit
import SnapKit

public final class CouponCell: UICollectionViewCell {
    private let couponView = CouponView(companyName: "발란스 스튜디오", count: 10, start: .now, end: .now)
    static let identifier = "CouponCell"
        
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
