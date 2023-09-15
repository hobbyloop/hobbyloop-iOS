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
        case .reservationTicketItem:
            guard let ticketSelectCell = tableView.dequeueReusableCell(withIdentifier: "TicketSelectCell", for: indexPath) as? TicketSelectCell else { return UITableViewCell() }
            return ticketSelectCell
        }
    }
        
    private lazy var ticketSelectTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
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
        self.view.backgroundColor = .white
        
        [ticketInfoLabel, ticketImageView, ticketdescriptionLabel,
         ticketSelectTableView, ticketButton, loofPassButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.left.equalToSuperview().offset(17)
            $0.width.equalTo(26)
            $0.height.equalTo(20)
        }
        
        ticketInfoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
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
            $0.top.equalTo(loofPassButton.snp.bottom).offset(31)
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
    
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let ticketFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TicketSelectReusableView") as? TicketSelectReusableView else { return UIView() }
        
        return ticketFooterView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}



//TODO: Tuist 오류로 인해 ViewController 따로 빼놓은 상태
extension UIView {
    
    
    func createTicketView(_ rect: CGRect, backgroundColor: UIColor, image: UIImage) -> UIView {

        let ticketView = UIView(frame: rect)
        let logoImageView = UIImageView(image: image)
        
        ticketView.backgroundColor = backgroundColor
        logoImageView.contentMode = .scaleToFill
        
        ticketView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(28)
            $0.height.equalTo(23)
            $0.center.equalToSuperview()
        }
        
        
        let maskPath = UIBezierPath(shouldRoundRect: ticketView.bounds, topLeftRadius: 10, topRightRadius: 3, bottomLeftRadius: 10, bottomRightRadius: 3)
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = maskPath.cgPath
        ticketView.layer.mask = maskLayer
        
        return ticketView
    }
    
}
