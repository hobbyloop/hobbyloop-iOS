//
//  HPCalendarTicketsCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/26.
//

import UIKit

import SnapKit



final class HPCalendarTicketsCell: UICollectionViewCell {
    
    
    private let ticketInfoView: TicketView = TicketView(
        title: "6:1 체형교정 필라테스",
        studioName: "필라피티 스튜디오",
        instructor: "이민주 강사님",
        timeString: Date().convertToString(),
        textColor: HPCommonUIAsset.black.color,
        fillColor: HPCommonUIAsset.systemBackground.color.cgColor
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
            $0.edges.equalToSuperview()
        }
        
        
    }
    
}



