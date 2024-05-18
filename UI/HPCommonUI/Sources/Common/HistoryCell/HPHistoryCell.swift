//
//  CouponUsageHistoryCell.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import SnapKit

public final class HPHistoryCell: UITableViewCell {
    public static let identifier = "HistoryCell"
    public static let height: CGFloat = 54
    
    private let dateLabel = UILabel().then {
        $0.text = ""
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 10)
        $0.textColor = HPCommonUIAsset.gray40.color
    }
    
    public var dateText: String {
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
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    public var title: String {
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
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    public var historyContent: String {
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
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    public var remainingAmountText: String {
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
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
        }
        
        historyContentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        remainingAmountLabel.snp.makeConstraints {
            $0.top.equalTo(historyContentLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
