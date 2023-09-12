//
//  HPCalendarBubbleDayCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/09.
//

import UIKit

import HPExtensions
import RxSwift
import RxCocoa
import ReactorKit
import Then
import SnapKit


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
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 16)
    }
    
    private var eventView: UIImageView = UIImageView.circularImageView(radius: 4)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.contentView.addSubview(bubbleView)
        self.contentView.addSubview(eventView)
        
        [weekDayLabel, dayLabel].forEach {
            self.bubbleView.addSubview($0)
        }
        
        eventView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalTo(bubbleView)
        }
        
        bubbleView.snp.makeConstraints {
            $0.top.equalTo(eventView.snp.bottom).offset(15)
            $0.left.right.bottom.equalToSuperview()
        }
        
        weekDayLabel.snp.makeConstraints {
            $0.width.equalTo(17)
            $0.height.equalTo(19)
            $0.top.equalToSuperview().offset(14)
            $0.centerX.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(20)
            $0.height.equalTo(19)
            $0.top.equalTo(weekDayLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
    }
    
    
}



extension HPCalendarBubbleDayCell: ReactorKit.View {
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.alpha }.debug("alpha test")
            .map { alpha in HPCommonUIAsset.horizontalDivider.color.withAlphaComponent(alpha) }
            .bind(to: bubbleView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.day }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.weekDay }
            .bind(to: weekDayLabel.rx.text)
            .disposed(by: disposeBag)

    }
}
