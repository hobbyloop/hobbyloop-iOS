//
//  HPCalendarBubbleDayCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/09.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit


public final class HPCalendarBubbleDayCellReactor: Reactor {
    
    public var initialState: State
    
    
    public typealias Action = NoAction
    
    public struct State {
        var day: String
        var weekDay: String
        var alpha: CGFloat
    }
    
    public init(day: String, weekDay: String, alpha: CGFloat) {
        self.initialState = State(day: day, weekDay: weekDay, alpha: alpha)
    }
}


final class HPCalendarBubbleDayCell: UICollectionViewCell {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    typealias Reactor = HPCalendarBubbleDayCellReactor
    
    private let bubbleView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let weekDayLabel: UILabel = UILabel().then {
        $0.text = "월"
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 16)
    }
    
    private let dayLabel: UILabel = UILabel().then {
        $0.text = "1"
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.contentView.addSubview(bubbleView)
        
        [weekDayLabel, dayLabel].forEach {
            self.bubbleView.addSubview($0)
        }
        
        
        
    }
    
    
}



extension HPCalendarBubbleDayCell: ReactorKit.View {
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.alpha }
            .bind(to: bubbleView.rx.alpha)
            .disposed(by: disposeBag)

    }
}
