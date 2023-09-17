//
//  TicketSelectCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import UIKit

import Then
import SnapKit
import RxDataSources
import ReactorKit
import HPCommonUI

public final class TicketSelectCell: UITableViewCell {
    
    //MARK: Property
    
    public typealias Reactor = TicketSelectCellReactor
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    private let iconImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.pilatesFilled.image
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.text = "발란스 스튜디오"
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textAlignment = .left
    }
    
    private let underLine: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.mercury.color
    }
    
    //TODO: API DTO에 따라 TicketInfoView Count 값이 넘겨질 경우 Multi TableView 구성 구현
    
    private lazy var ticketStakView: UIStackView = UIStackView().then {
        $0.spacing = 26
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    
    private lazy var ticketView: TicketInfoView = TicketInfoView(
        ticketSize: CGSize(width: 70, height: 40),
        ticketColor: HPCommonUIAsset.black.color,
        ticketImage: HPCommonUIAsset.ticketlogoFilled.image
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        ticketStakView.addArrangedSubview(ticketView)
        
        [iconImageView, nameLabel, underLine, ticketStakView].forEach {
            self.contentView.addSubview($0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(26)
            $0.height.equalTo(21)
            $0.top.equalToSuperview().offset(28)
            $0.left.equalToSuperview().offset(29)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31)
            $0.left.equalTo(iconImageView.snp.right).offset(11)
            $0.height.equalTo(20)
            $0.centerY.equalTo(iconImageView)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(17)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(14)
            $0.right.equalToSuperview().offset(-14)
        }
        
        ticketView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        ticketStakView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(1)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
}



extension TicketSelectCell: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.model}
            .bind(to: ticketView.rx.reactor)
            .disposed(by: disposeBag)
    }
}
