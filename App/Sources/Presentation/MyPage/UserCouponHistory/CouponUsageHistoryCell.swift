//
//  CouponUsageHistoryCell.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import HPCommonUI

final class CouponUsageHistoryCell: UITableViewCell {
    static let identifier = "CouponUsageHistoryCell"
    static let height: CGFloat = 54
    
    private let dateLabel = UILabel().then {
        $0.text = "03.10"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.historyDateLabel.color
    }
    
    var date: String {
        get {
            dateLabel.text ?? ""
        }
        
        set {
            dateLabel.text = newValue
        }
    }
    
    private let studioNameLabel = UILabel().then {
        $0.text = "필라피티 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    var studioName: String {
        get {
            studioNameLabel.text ?? ""
        }
        
        set {
            studioNameLabel.text = newValue
        }
    }
    
    private let historyContentLabel = UILabel().then {
        $0.text = "1회 충전"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    var historyContent: String {
        get {
            historyContentLabel.text ?? ""
        }
        
        set {
            historyContentLabel.text = newValue
        }
    }
    
    private let remainingCountLabel = UILabel().then {
        $0.text = "5회"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.historyDateLabel.color
    }
    
    var remainingCount = 5 {
        didSet {
            remainingCountLabel.text = "\(remainingCount)회"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [dateLabel, studioNameLabel, historyContentLabel, remainingCountLabel].forEach(contentView.addSubview(_:))
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(41)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(17)
        }
        
        historyContentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-42)
            $0.top.equalTo(dateLabel.snp.top)
        }
        
        remainingCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(historyContentLabel.snp.trailing)
            $0.top.equalTo(historyContentLabel.snp.bottom).offset(4)
        }
    }
}
