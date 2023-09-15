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

public final class ReservationTicketCell: UITableViewCell {
    
    //MARK: Property
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        
    }
}
