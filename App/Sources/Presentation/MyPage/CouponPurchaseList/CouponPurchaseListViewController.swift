//
//  CouponPurchaseListViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/12.
//

import UIKit
import HPCommonUI

class CouponPurchaseListViewController: UIViewController {
    // TODO: API 통해 이용권 구매 데이터 받아오고 날짜별로 grouping하기
    
    // MARK: - custom navigation bar
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.text = "이용권 구매내역"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
    }
    
    private lazy var customNavigationBar = UIView().then {
        [backButton, navigationTitleLabel].forEach($0.addSubview(_:))
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }
    
    // MARK: - table view
    let tableView = UITableView().then {
        $0.backgroundColor = HPCommonUIAsset.lightBackground.color
        $0.separatorStyle = .none
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CouponPurchaseHistoryCell.self, forCellReuseIdentifier: CouponPurchaseHistoryCell.identifier)
        tableView.register(CouponPurchaseHistoryHeaderCell.self, forCellReuseIdentifier: CouponPurchaseHistoryHeaderCell.identifier)
    }
    
    // MARK: - layout
    private func layout() {
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            $0.height.equalTo(56)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CouponPurchaseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? CouponPurchaseHistoryHeaderCell.height : CouponPurchaseHistoryCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 14))
    }
}

extension CouponPurchaseListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // TODO: grouping한 이용권 구매내역 데이터로부터 날짜 받아오기
            let cell = tableView.dequeueReusableCell(withIdentifier: CouponPurchaseHistoryHeaderCell.identifier) as! CouponPurchaseHistoryHeaderCell
            cell.isUserInteractionEnabled = false
            
            return cell
        } else {
            // TODO: indexPath.row - 1 을 사용하여 데이터에 접근하기
            let cell = tableView.dequeueReusableCell(withIdentifier: CouponPurchaseHistoryCell.identifier) as! CouponPurchaseHistoryCell
            cell.isUserInteractionEnabled = false
            
            return cell
        }
    }
}
