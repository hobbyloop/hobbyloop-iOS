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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = .systemPink
        
    }
    
    
}
