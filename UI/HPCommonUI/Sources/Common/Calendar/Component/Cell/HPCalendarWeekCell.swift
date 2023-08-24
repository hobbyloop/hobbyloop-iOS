//
//  HPCalendarWeekCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/23.
//

import UIKit

import ReactorKit
import RxCocoa
import SnapKit
import Then



final class HPCalendarWeekCellReactor: Reactor {
    var initialState: State
    
    typealias Action = NoAction

    
    struct State {
        var week: String
    }
    
    init(week: String) {
        self.initialState = State(week: week)
    }
    
}



final class HPCalendarWeekCell: UICollectionViewCell {
    
    typealias Reactor = HPCalendarWeekCellReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    public let weekDayLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.lightGray.color
        $0.textAlignment = .center
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.contentView.addSubview(weekDayLabel)
        
        weekDayLabel.snp.makeConstraints {
            $0.width.equalTo(13)
            $0.height.equalTo(17)
            $0.center.equalToSuperview()
        }
        
        
        
    }
    
    
}


extension HPCalendarWeekCell: ReactorKit.View {

    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.week }
            .asDriver(onErrorJustReturn: "")
            .drive(weekDayLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
