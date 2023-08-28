//
//  ScheduleCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/12.
//

import UIKit

import HPCommonUI
import Then


final class ScheduleCell: UICollectionViewCell {
    
    //MARK: Property
    
    private let emptyCouponView: EmptyTicketView = EmptyTicketView(topLeftRadius: 40, topRightRadius: 5, bottomLeftRadius: 40, bottomRightRadius: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(emptyCouponView)
        
        
        emptyCouponView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(143)
        }
    }
    
    
}
