//
//  HPCalendarDayCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/24.
//

import UIKit


import ReactorKit
import RxCocoa
import Then
import SnapKit


public final class HPCalendarDayCellReactor: Reactor {
    public var initialState: State
    
    
    // TODO: 사용자가 Cell 클릭시 사용자가 가지고 있는 이용권 리스트 조회 API 호출
    public typealias Action = NoAction
    
    public struct State {
        var days: String
        var isCompare: Bool
    }
    
    public init(days: String, isCompare: Bool) {
        print("Days State: \(days) or iscompare: \(isCompare)")
        self.initialState = State(days: days, isCompare: isCompare)
    }
    
    
}




final class HPCalendarDayCell: UICollectionViewCell {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    typealias Reactor = HPCalendarDayCellReactor
    
    private let dayLabel: UILabel = UILabel().then {
        $0.text = "일"
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.contentView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(17)
            $0.center.equalToSuperview()
        }
        
    }
}



extension HPCalendarDayCell: ReactorKit.View {
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.days }
            .debug("Day Cell")
            .asDriver(onErrorJustReturn: "")
            .drive(dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.isCompare  == false}
            .map { _ in HPCommonUIAsset.lineSeparator.color }
            .asDriver(onErrorJustReturn: .separator)
            .drive(dayLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.isCompare == true }
            .map { _ in HPCommonUIAsset.black.color }
            .asDriver(onErrorJustReturn: .separator)
            .drive(dayLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        
        
    }
    
}
