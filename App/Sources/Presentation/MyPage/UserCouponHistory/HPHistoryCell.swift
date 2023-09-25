//
//  CouponUsageHistoryCell.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import HPCommonUI

public final class HPHistoryCell: UITableViewCell {
    static let identifier = "HistoryCell"
    static let height: CGFloat = 54
    
    private let dateLabel = UILabel().then {
        $0.text = ""
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.historyDateLabel.color
    }
    
    var dateText: String {
        get {
            dateLabel.text ?? ""
        }
        
        set {
            dateLabel.text = newValue
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    var title: String {
        get {
            titleLabel.text ?? ""
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    private let historyContentLabel = UILabel().then {
        $0.text = ""
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
    
    private let remainingAmountLabel = UILabel().then {
        $0.text = ""
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.historyDateLabel.color
    }
    
    var remainingAmountText: String {
        get {
            remainingAmountLabel.text ?? ""
        }
        
        set {
            remainingAmountLabel.text = newValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [dateLabel, titleLabel, historyContentLabel, remainingAmountLabel].forEach(contentView.addSubview(_:))
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalToSuperview().offset(41)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(17)
        }
        
        historyContentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-42)
            $0.top.equalTo(dateLabel.snp.top)
        }
        
        remainingAmountLabel.snp.makeConstraints {
            $0.trailing.equalTo(historyContentLabel.snp.trailing)
            $0.top.equalTo(historyContentLabel.snp.bottom).offset(4)
        }
    }
}
