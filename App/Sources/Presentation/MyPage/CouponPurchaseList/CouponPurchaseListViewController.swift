//
//  CouponPurchaseListViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/12.
//

import UIKit
import HPCommonUI

class CouponPurchaseListViewController: UIViewController {
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
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
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
