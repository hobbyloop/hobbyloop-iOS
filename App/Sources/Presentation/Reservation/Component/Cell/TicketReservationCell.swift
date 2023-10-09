//
//  TicketReservationCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import UIKit

import Then
import SnapKit
import HPCommonUI


public final class TicketReservationCell: UICollectionViewCell {
    
    private let reservationTicketView: TicketView = TicketView(
        title: "6:1 체형교정 필라테스",
        studioName: "필파피티 스튜디오",
        instructor: "이민주 강사님",
        timeString: Date().convertToString(),
        textColor: HPCommonUIAsset.black.color,
        fillColor: HPCommonUIAsset.systemBackground.color.cgColor
    )
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(reservationTicketView)
        
        reservationTicketView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
    }
    
    
    
}
