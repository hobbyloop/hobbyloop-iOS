//
//  TicketCalendarCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/27.
//

import UIKit

import HPCommonUI
import Then
import SnapKit
import ReactorKit
import RxCocoa


public protocol TicketCalendarDelegate: AnyObject {
    func didTapCalendarStyleButton(isStyle: CalendarStyle)
}


public final class TicketCalendarCell: UICollectionViewCell {
    
    //MARK: Property
    
    public weak var delegate: TicketCalendarDelegate?
    
    public typealias Reactor = TicketCalendarCellReactor
    public var disposeBag: DisposeBag = DisposeBag()
    
    private lazy var calendarView: HPCalendarView = HPCalendarView(
        reactor: HPCalendarViewReactor(calendarConfigureProxy: HPCalendarProxyBinder()), calendarContentView: HPCalendarContentView(),
        isStyle: .bubble
    )
    
    private let styleButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.calendarOutlined.image, for: .normal)
        $0.setImage(HPCommonUIAsset.calendarFilled.image, for: .selected)
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [calendarView, styleButton].forEach {
            self.contentView.addSubview($0)
        }
        
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        styleButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.width.height.equalTo(24)
            $0.right.equalToSuperview().offset(-24)
        }
        
        
    }
    
    
    
    
}


extension TicketCalendarCell: ReactorKit.View {

    
    public func bind(reactor: Reactor) {
        styleButton
            .rx.tap
            .map { Reactor.Action.didTapCalendarStyleButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isStyle == .bubble ? false : true }
            .bind(to: styleButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isStyle == .bubble ? true : false }
            .bind(to: calendarView.rx.isStatus)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isStyle }
            .observe(on: MainScheduler.instance)
            .bind(onNext: { isStyle in
                self.calendarView.isStyle = isStyle
                self.delegate?.didTapCalendarStyleButton(isStyle: isStyle)
                self.calendarView.reactor?.action.onNext(.changeCalendarStyle(isStyle))
            })
            .disposed(by: disposeBag)
        
    }
    
}
