//
//  HPCalendarView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/07/27.
//

import UIKit

import Then

final class HPCalendarView: UIView {
    
    
    // MARK: Property
    private var calendarCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 35, height: 35)
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    }
    
    private lazy var calendarCollectionView: UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: calendarCollectionViewLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



