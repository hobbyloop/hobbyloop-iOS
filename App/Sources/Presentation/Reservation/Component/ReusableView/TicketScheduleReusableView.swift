//
//  TicketScheduleReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/27.
//

import UIKit

import SnapKit
import Then
import HPCommonUI

public final class TicketScheduleReusableView: UICollectionReusableView {
    
    
    private let scheduleTimeImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.time.image
    }
    
    private let scheduleTimeLabel: UILabel = UILabel().then {
        $0.text = "가능수업"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [scheduleTimeImageView, scheduleTimeLabel].forEach {
            self.addSubview($0)
        }
        
        scheduleTimeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.left.equalToSuperview().offset(26)
            $0.width.height.equalTo(16)
        }
        
        scheduleTimeLabel.snp.makeConstraints {
            $0.left.equalTo(scheduleTimeImageView.snp.right).offset(18)
            $0.height.equalTo(21)
            $0.centerY.equalTo(scheduleTimeImageView)
        }
    }
    
    
    
}
