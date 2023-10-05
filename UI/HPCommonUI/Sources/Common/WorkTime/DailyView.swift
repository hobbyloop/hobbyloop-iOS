//
//  DailyView.swift
//  HPCommon
//
//  Created by 김진우 on 2023/08/25.
//

import UIKit

public class DailyView: UIView {
    private var dayLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.originSeparator.color
    }
    
    private var timeLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        [dayLabel, timeLabel].forEach {
            addSubview($0)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
            $0.width.equalTo(13)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(31)
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(86)
        }
    }
    
    public func configure(_ daily: DailyTime) {
        dayLabel.text = daily.day
        timeLabel.text = daily.time
    }
}
