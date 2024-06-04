//
//  ClassHistoryFooterView.swift
//  Hobbyloop
//
//  Created by 김남건 on 5/14/24.
//

import UIKit
import SnapKit
import HPCommonUI

final class ClassHistoryFooterView: UICollectionReusableView {
    static let identifier = "ClassHistoryFooterView"
    static let height: CGFloat = 64
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        let dividerView = UIView()
        dividerView.backgroundColor = HPCommonUIAsset.gray20.color
        
        self.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
}
