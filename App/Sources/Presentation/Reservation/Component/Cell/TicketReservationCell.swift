//
//  TicketReservationCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/15.
//

import UIKit

import SnapKit
import Then
import HPCommonUI
import HPExtensions

public final class TicketReservationCell: UITableViewCell {
    
    //MARK: Property
    
    private let lessonTicketView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40)).createTicketView(
        CGRect(x: 0, y: 0, width: 70, height: 40),
        backgroundColor: HPCommonUIAsset.black.color,
        image: HPCommonUIAsset.ticketlogoFilled.image
    )
    
    private let lessonNameLabel: UILabel = UILabel().then {
        $0.text = "6:1 그룹레슨 30회"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textAlignment = .left
    }
    
    private let lessoneDateLabel: UILabel = UILabel().then {
        $0.text = "2023.04.20 - 2023.06.20"
        $0.textColor = HPCommonUIAsset.onyx.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textAlignment = .left
    }
    
    private let arrowImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.rightarrow.image
    }
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [lessonTicketView, lessonNameLabel, lessoneDateLabel, arrowImageView].forEach {
            self.contentView.addSubview($0)
        }
                
        lessonTicketView.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.left.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(25)
        }
        
        lessonNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.left.equalTo(lessonTicketView.snp.right).offset(19)
            $0.height.equalTo(10)
            $0.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        lessoneDateLabel.snp.makeConstraints {
            $0.top.equalTo(lessonNameLabel.snp.bottom).offset(7)
            $0.left.equalTo(lessonTicketView.snp.right).offset(19)
            $0.height.equalTo(12)
            $0.right.equalTo(arrowImageView.snp.right).offset(-10)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(lessonTicketView)
            $0.right.equalToSuperview().offset(-16)
        }
        
    }
}
