//
//  TicketCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/28.
//

import UIKit

import HPCommonUI

public final class TicketCell: UICollectionViewCell {
    
    
    private let ticketInfoView: TicketView = TicketView(
        title: "6:1 체형교정 필라테스",
        studioName: "필라피티 스튜디오",
        instructor: "이민주 강사님",
        timeString: Date().convertToString(),
        textColor: HPCommonUIAsset.black.color,
        fillColor: HPCommonUIAsset.white.color.cgColor
    )
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(ticketInfoView)
        
        ticketInfoView.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        
    }
    
}




