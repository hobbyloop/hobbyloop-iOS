//
//  CalendarCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/26.
//

import UIKit


import HPCommonUI
import Then



public final class CalendarCell: UICollectionViewCell {
    
    private lazy var calendarView: HPCalendarView = HPCalendarView(reactor: HPCalendarViewReactor(calendarConfigureProxy: HPCalendarProxyBinder()), calendarContentView: HPCalendarContentView(), isStyle: .default, weekViewColor: HPCommonUIAsset.systemBackground.color).then {
        $0.color = HPCommonUIAsset.systemBackground.color
    }
    
    
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
