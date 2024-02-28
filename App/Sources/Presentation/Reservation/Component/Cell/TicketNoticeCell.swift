//
//  TicketNoticeCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import UIKit

import HPCommonUI

public final class TicketNoticeCell: UICollectionViewCell {
    
    private let noticeTextView: UITextView = UITextView().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray3.color
        $0.isUserInteractionEnabled = false
        $0.text = "balance SUDIO는 강사진과 트레이너들의 체계적인 Pilates & Wegiht Program 제공하는 퍼스널 트레이닝 스튜디오 입니..."
        $0.backgroundColor = .clear
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.contentView.addSubview(noticeTextView)
        
        noticeTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
}
