//
//  TicketInfoView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/17.
//

import UIKit

import SnapKit
import Then
import ReactorKit
import RxCocoa


public final class TicketInfoView: UIView {
    
    
    //MARK: Property
    private var ticketSize: CGSize
    private var ticketColor: UIColor
    private var ticketImage: UIImage
    
    
    public typealias Reactor = TicketInfoViewReactor
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    private let lessonNameLabel: UILabel = UILabel().then {
        $0.text = "6:1 그룹레슨 30회"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textAlignment = .left
    }
    
    private let lessonDateLabel: UILabel = UILabel().then {
        $0.text = "2023.04.20 - 2023.06.20"
        $0.textColor = HPCommonUIAsset.onyx.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textAlignment = .left
    }
    
    private let arrowImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = HPCommonUIAsset.rightarrow.image
    }
    
    
    public init(reactor: TicketInfoViewReactor? = nil, ticketSize: CGSize, ticketColor: UIColor, ticketImage: UIImage) {
        self.ticketSize = ticketSize
        self.ticketColor = ticketColor
        self.ticketImage = ticketImage
        super.init(frame: .zero)
        self.reactor = reactor
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    
    private func configure() {
        let lessonTicketView = createTicketView(
            CGRect(x: 0, y: 0, width: ticketSize.width, height: ticketSize.height),
            backgroundColor: ticketColor,
            image: ticketImage
        )
        
        
        [lessonTicketView , lessonNameLabel, lessonDateLabel, arrowImageView].forEach {
            self.addSubview($0)
        }
        
        
        lessonTicketView.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.left.equalToSuperview().offset(23)
            $0.top.equalToSuperview().offset(25)
        }
        
        
        lessonNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.left.equalTo(lessonTicketView.snp.right).offset(19)
            $0.height.equalTo(13)
            $0.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        lessonDateLabel.snp.makeConstraints {
            $0.top.equalTo(lessonNameLabel.snp.bottom).offset(7)
            $0.left.equalTo(lessonTicketView.snp.right).offset(19)
            $0.height.equalTo(12)
            $0.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.centerY.equalTo(lessonTicketView)
            $0.right.equalToSuperview().offset(-24)
        }

    }
    
}



extension TicketInfoView: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.lessonName }
            .bind(to: lessonNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.lessonDate }
            .bind(to: lessonDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        //TODO: TicketView Instance Property로 선언시 적용
//        reactor.state
//            .map { $0.color }
//            .map { HPCommonUIColors.Color(named: $0, in: HPCommonUIResources.bundle, compatibleWith: nil) }
//            .bind(to: self.ticketView.rx.backgroundColor)
//            .disposed(by: disposeBag)
    }
    
}
