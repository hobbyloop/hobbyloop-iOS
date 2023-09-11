//
//  CalendarCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/26.
//

import UIKit


import HPCommonUI
import Then



final class CalendarCell: UICollectionViewCell {
    
    private let calendarView: HPCalendarView = HPCalendarView(reactor: HPCalendarViewReactor())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        
    }
    
}
