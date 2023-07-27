//
//  HPCalendarView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/07/27.
//

import UIKit

import Then

final class HPCalendarView: UIView {
    
    
    private lazy var calendarCollectionView: UICollectionView = UICollectionView(frame: self.frame)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



