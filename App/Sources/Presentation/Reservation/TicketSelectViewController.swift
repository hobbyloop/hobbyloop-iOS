//
//  TicketSelectViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxDataSources

import HPCommonUI

public final class TicketSelectViewController: BaseViewController<TicketSelectViewReactor> {
    
    
    
    //MARK: Property
    private lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.white.color
    }
    
    private let ticketInfoLabel: UILabel = UILabel().then {
        $0.text = "3개의 이용권이 있어요"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.textAlignment = .left
    }
    
    private let ticketImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticket.image
    }
    
    private let ticketdescriptionLabel: UILabel = UILabel().then {
        $0.text = "어떤 이용권을 사용하실건가요?"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.textAlignment = .left
    }
    
    
    private let ticketButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        $0.setTitle("이용권", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    private let loofPassButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        
        $0.setTitle("루프패스", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    private lazy var ticketSelectDataSource: RxTableViewSectionedReloadDataSource<TicketSelectSection> = .init { dataSource, tableView, indexPath, sectionItem in
        switch sectionItem {
        case let .reservationTicketItem(cellReactor):
            guard let ticketSelectCell = tableView.dequeueReusableCell(withIdentifier: "TicketSelectCell", for: indexPath) as? TicketSelectCell else { return UITableViewCell() }
            ticketSelectCell.reactor = cellReactor
            ticketSelectCell.delegate = self
            return ticketSelectCell
        }
    }
        
    private lazy var ticketSelectTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.rowHeight = UITableView.automaticDimension
        $0.register(TicketSelectCell.self, forCellReuseIdentifier: "TicketSelectCell")
        $0.register(TicketSelectReusableView.self, forHeaderFooterViewReuseIdentifier: "TicketSelectReusableView")
    }
    
    //MARK: LifeCycle
    
    override public init(reactor: TicketSelectViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: Configure
    
    private func configure() {
        self.view.backgroundColor = HPCommonUIAsset.systemBackground.color
        self.containerView.layer.cornerRadius = 15
        self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.containerView.clipsToBounds = true
        
        [containerView,ticketSelectTableView].forEach {
            self.view.addSubview($0)
        }
        
        [ticketInfoLabel, ticketImageView,ticketdescriptionLabel,
         ticketButton, loofPassButton].forEach {
            self.containerView.addSubview($0)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(231)
        }
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(18)
            $0.left.equalToSuperview().offset(17)
            $0.width.equalTo(26)
            $0.height.equalTo(20)
        }
        
        ticketInfoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(18)
            $0.left.equalTo(ticketImageView.snp.right).offset(10)
            $0.centerY.equalTo(ticketImageView)
            $0.height.equalTo(20)
        }
        
        ticketdescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(ticketInfoLabel.snp.bottom).offset(18)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        
        ticketButton.snp.makeConstraints {
            $0.top.equalTo(ticketdescriptionLabel.snp.bottom).offset(18)
            $0.left.equalTo(17)
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
        
        loofPassButton.snp.makeConstraints {
            $0.top.equalTo(ticketButton)
            $0.left.equalTo(ticketButton.snp.right).offset(8)
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
        
        ticketSelectTableView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        
    }
    
    public override func bind(reactor: TicketSelectViewReactor) {
        
        Observable
            .just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.ticketSelectTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$section)
            .asDriver(onErrorJustReturn: [])
            .drive(ticketSelectTableView.rx.items(dataSource: self.ticketSelectDataSource))
            .disposed(by: disposeBag)
    }
    
    
    
    
}




extension TicketSelectViewController: UITableViewDelegate {
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let ticketHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TicketSelectReusableView") as? TicketSelectReusableView else { return UIView() }
        
        return ticketHeaderView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let ticketFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TicketSelectReusableView") as? TicketSelectReusableView else { return UIView() }
        
        return ticketFooterView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}


extension TicketSelectViewController: TicketUserInfoViewDelegate {
    
    
    public func createTicketTimeViewController() {
        let ticketSelectTimeDIController = TicketSelectTimeDIContainer().makeViewController()
        ticketSelectTimeDIController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ticketSelectTimeDIController, animated: true)
        
    }
    
}
