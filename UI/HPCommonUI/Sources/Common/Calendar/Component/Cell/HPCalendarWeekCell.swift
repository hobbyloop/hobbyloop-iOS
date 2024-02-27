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



public final class HPCalendarWeekCell: UICollectionViewCell {
    
    public typealias Reactor = HPCalendarWeekCellReactor
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public let weekDayLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray4.color
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

    
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.week }
            .asDriver(onErrorJustReturn: "")
            .drive(weekDayLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
