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
import Then
import SnapKit
import HPFoundation


public final class HPCalendarBubbleDayCell: UICollectionViewCell {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public typealias Reactor = HPCalendarBubbleDayCellReactor
    
    private let bubbleView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.mainColor.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let weekDayLabel: UILabel = UILabel().then {
        $0.text = "월"
        $0.textColor = HPCommonUIAsset.gray8.color
        $0.textAlignment = .center
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 16)
    }
    
    private let dayLabel: UILabel = UILabel().then {
        $0.text = "1"
        $0.textColor = HPCommonUIAsset.gray8.color
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
    
    public func bind(reactor: Reactor) {
        
        reactor.state
            .map { $0.day }
            .distinctUntilChanged()
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.weekDay }
            .distinctUntilChanged()
            .bind(to: weekDayLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isCompare == true ? HPCommonUIAsset.mainColor.color : HPCommonUIAsset.gray3.color   }
            .bind(to: bubbleView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.nowDay == $0.day ? false : true }
            .bind(to: eventView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.nowDay == $0.day ? HPCommonUIAsset.gray1.color : HPCommonUIAsset.gray8.color }
            .bind(to: dayLabel.rx.textColor)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.nowDay == $0.day ? HPCommonUIAsset.gray1.color : HPCommonUIAsset.gray8.color }
            .bind(to: weekDayLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.nowDay == $0.day ? HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16) : HPCommonUIFontFamily.Pretendard.regular.font(size: 16) }
            .bind(to: dayLabel.rx.font)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.nowDay == $0.day ? HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16) : HPCommonUIFontFamily.Pretendard.regular.font(size: 16) }
            .bind(to: weekDayLabel.rx.font)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.color }
            .map { HPCommonUIColors.Color(named: $0, in: HPCommonUIResources.bundle, compatibleWith: nil)}
            .bind(to: bubbleView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
}
