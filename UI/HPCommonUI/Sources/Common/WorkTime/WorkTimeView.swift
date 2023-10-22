//
//  WorkTimeView.swift
//  HPCommon
//
//  Created by 김진우 on 2023/08/25.
//

import UIKit

/// Notice: 날짜를 표현하기 위한 뷰 입니다. ex) 월 09:00 ~ 12:00
/// Layout: Width: 236, Height: 54 + ( 개수 * 17)
/// How use?: Configure에 일정을 넣어줍니다. Type은 DailyTime 입니다.
public class WorkTimeView: UIView {
    private var dailyList: [DailyTime] = []
    
    private var dailyStack: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private var dailyView: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(dailyStack)
        
        dailyStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(53)
            $0.top.bottom.equalToSuperview().inset(27)
        }
    }
    
    public func configure(_ daily: [DailyTime]) {
        dailyList = daily
        
        daily.forEach { list in
            let view = DailyView()
            view.configure(list)
            
            dailyList.append(list)
            dailyView.append(view)
            dailyStack.addArrangedSubview(view)
        }
        
        setNeedsLayout()
    }
}
