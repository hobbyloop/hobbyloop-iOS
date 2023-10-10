//
//  TicketTypeCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/10.
//

import UIKit

import HPCommonUI

public final class TicketTypeCell: UICollectionViewCell {
    
    private let ticketButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        $0.setTitle("이용권", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    private let loopPassButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("루프패스", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.couponTypeButtonTint.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [ticketButton, loopPassButton].forEach {
            self.contentView.addSubview($0)
        }
        
        
        ticketButton.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(26)
            $0.top.equalToSuperview().offset(19)
            $0.left.equalToSuperview().offset(16)
        }
        
        loopPassButton.snp.makeConstraints {
            $0.width.height.equalTo(ticketButton)
            $0.left.equalTo(ticketButton.snp.right).offset(8)
            $0.centerY.equalTo(ticketButton)
        }
        
    }
    
    
}
