//
//  HPCalendarDayCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/24.
//

import UIKit

import Then
import SnapKit



final class HPCalendarDayCell: UICollectionViewCell {
    
    
    private let dayLabel: UILabel = UILabel().then {
        $0.text = "일"
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(17)
            $0.center.equalToSuperview()
        }
        
    }
}
