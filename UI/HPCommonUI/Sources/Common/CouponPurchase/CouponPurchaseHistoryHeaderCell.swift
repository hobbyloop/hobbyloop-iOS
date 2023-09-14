//
//  CouponPurchaseHistoryHeaderCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/09/12.
//

import UIKit
import SnapKit

public final class CouponPurchaseHistoryHeaderCell: UITableViewCell {
    public static let identifier = "CouponPurchaseHistoryHeaderCell"
    public static let height: CGFloat = 51.5
    
    public let dateLabel = UILabel().then {
        $0.text = "2023년 9월 12일"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(19)
        }
    }
}
