//
//  UserCouponHistoryViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import HPCommonUI

final class UserCouponHistoryViewController: UIViewController {
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        $0.configuration?.contentInsets = .init(top: 7, leading: 10, bottom: 7, trailing: 10)
    }
    
    // MARK: - coupon type buttons
    private let usableCouponButton = HPNewButton(title: "사용", style: .bordered, unselectedTitleColor: HPCommonUIAsset.gray100.color).then {
        $0.layer.cornerRadius = 17
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.isSelected = true
    }
    private let expiredCouponButton = HPNewButton(title: "소멸", style: .bordered, unselectedTitleColor: HPCommonUIAsset.gray100.color).then {
        $0.layer.cornerRadius = 17
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.isSelected = false
    }
    
    private lazy var categoryButtonsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    // MARK: - coupon list
    private let couponListView = CouponListView()
    
    private let bottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - table view
    private lazy var historyTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.sectionFooterHeight = 0
        $0.tableFooterView = UIView(
            frame: CGRect(origin: .zero,
                          size: CGSize(
                            width:CGFloat.leastNormalMagnitude,
                            height: CGFloat.leastNormalMagnitude
                          )
                         )
        )
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layout()
        configureHistoryTableView()
    }
    
    // MARK: - layout methods
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "이용권"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layout() {
        [usableCouponButton, expiredCouponButton].forEach { [weak self] in
            $0.snp.makeConstraints {
                $0.width.equalTo(54)
                $0.height.equalTo(34)
            }
            
            self?.categoryButtonsStack.addArrangedSubview($0)
        }
        
        [
            categoryButtonsStack,
            couponListView,
            bottomMarginView,
            historyTableView
        ].forEach(view.addSubview(_:))
        
        categoryButtonsStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
        }
        
        couponListView.snp.makeConstraints {
            $0.top.equalTo(categoryButtonsStack.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomMarginView.snp.makeConstraints {
            $0.top.equalTo(couponListView.snp.bottom).offset(24)
            $0.height.equalTo(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(bottomMarginView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureHistoryTableView() {
        historyTableView.register(HPHistoryCell.self, forCellReuseIdentifier: HPHistoryCell.identifier)
        historyTableView.register(HPHistoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HPHistoryTableViewHeader.identifier)
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
}

// MARK: - table view data source
extension UserCouponHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: 데이터 반영
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: 데이터 반영
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HPHistoryTableViewHeader.identifier) as! HPHistoryTableViewHeader
        
        header.title = "2023년 5월"
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HPHistoryCell.identifier) as! HPHistoryCell
        cell.dateText = "03.10"
        cell.title = "필라피티 스튜디오"
        cell.historyContent = "1회 충전"
        cell.remainingAmountText = "5회"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HPHistoryTableViewHeader.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HPHistoryCell.height
    }
}
