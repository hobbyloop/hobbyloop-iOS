//
//  SortTableViewCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 10/27/23.
//

import UIKit

import HPCommonUI
import RxSwift

public class SortTableViewCell: UITableViewCell {
    private lazy var title: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(title)
        
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    public func titleStting(_ text: String) {
        title.text = text
    }
}
