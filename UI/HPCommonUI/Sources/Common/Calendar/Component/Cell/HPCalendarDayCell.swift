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


public final class HPCalendarDayCell: UICollectionViewCell {
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public typealias Reactor = HPCalendarDayCellReactor
    
    private let dayLabel: UILabel = UILabel().then {
        $0.text = "일"
        $0.textColor = HPCommonUIAsset.gray8.color
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
    
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.days }
            .asDriver(onErrorJustReturn: "")
            .drive(dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.isCompare  == false}
            .map { _ in HPCommonUIAsset.gray4.color }
            .asDriver(onErrorJustReturn: .separator)
            .drive(dayLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.isCompare == true }
            .map { _ in HPCommonUIAsset.gray8.color }
            .asDriver(onErrorJustReturn: .separator)
            .drive(dayLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        
        
    }
    
}
