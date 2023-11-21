//
//  CouponPurchaseHistoryCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/09/12.
//

import UIKit
import Then
import SnapKit

public final class CouponPurchaseHistoryCell: UITableViewCell {
    public static let identifier = "CouponPurchaseHistoryCell"
    public static let height: CGFloat = 74
    
    public let couponImageView = UIImageView(image: HPCommonUIAsset.hpTicket.image).then {
        $0.snp.makeConstraints {
            $0.width.equalTo(52)
            $0.height.equalTo(32)
        }
    }
    
    public let studioNameLabel = UILabel().then {
        $0.text = "하비루프"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
    }
    
    public let classNameLabel = UILabel().then {
        $0.text = "6:1 그룹레슨 30회"
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray4.color
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .systemBackground
        [couponImageView, studioNameLabel, classNameLabel].forEach(contentView.addSubview(_:))
        
        couponImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(couponImageView.snp.top).offset(-7)
            $0.leading.equalTo(couponImageView.snp.trailing).offset(18)
        }
        
        classNameLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(studioNameLabel.snp.leading)
        }
    }
}
