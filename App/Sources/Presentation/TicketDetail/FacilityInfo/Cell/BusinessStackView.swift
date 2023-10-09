//
//  BusinessStackView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/09.
//

import UIKit
import HPCommonUI

class BusinessStackView: UIStackView {
    private let textColor: UIColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1)
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.textColor = textColor
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    private lazy var subscribeLabel: UILabel = UILabel().then {
        $0.textColor = textColor
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        axis = .horizontal
        alignment = .leading
        spacing = 12
        
        [titleLabel, subscribeLabel].forEach {
            addArrangedSubview($0)
        }
    }
    
    public func configure(_ title: String, _ subscribe: String) {
        titleLabel.text = title
        subscribeLabel.text = subscribe
    }
}
