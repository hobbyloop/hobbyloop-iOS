//
//  ClassHisotryHeaderView.swift
//  Hobbyloop
//
//  Created by 김남건 on 5/14/24.
//

import UIKit
import SnapKit
import HPCommonUI

final class ClassHisotryHeaderView: UICollectionReusableView {
    static let identifier = "ClassHisotryHeaderView"
    static let height: CGFloat = 34
    
    private let titleLabel = UILabel().then {
        $0.text = "2024년 5월"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
