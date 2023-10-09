//
//  TicketNoticeReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import UIKit

import HPCommonUI
import Then
import SnapKit

public final class TicketNoticeReusableView: UICollectionReusableView {
    
    private let contentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.notificationFilled.image
    }
    
    private let contentTitleLabel: UILabel = UILabel().then {
        $0.text = "공지사항"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.defaultSeparator.color
        $0.textAlignment = .justified
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [contentImageView, contentTitleLabel].forEach {
            self.addSubview($0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().offset(17)
            $0.left.equalToSuperview().offset(16)
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.left.equalTo(contentImageView.snp.right).offset(6)
            $0.height.equalTo(19)
            $0.centerY.equalTo(contentImageView)
        }
        
        
    }
    
    
    
}
