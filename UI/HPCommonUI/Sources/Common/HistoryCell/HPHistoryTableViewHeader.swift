//
//  HPHistoryTableViewHeader.swift
//  HPCommonUI
//
//  Created by 김남건 on 5/13/24.
//

import UIKit
import SnapKit

public final class HPHistoryTableViewHeader: UITableViewHeaderFooterView {
    public static let identifier = "HPHistoryTableViewHeader"
    public static let height: CGFloat = 36
    
    private let titleLabel = UILabel().then {
        $0.text = "2024년 5월"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 10)
        $0.textColor = HPCommonUIAsset.gray80.color
    }
    public var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
