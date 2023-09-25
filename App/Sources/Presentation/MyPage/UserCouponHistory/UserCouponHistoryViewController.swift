//
//  UserCouponHistoryViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import HPCommonUI

final class UserCouponHistoryViewController: UIViewController {
    // MARK: - navigation bar back button
    private let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 22)).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image, for: .normal)
    }
    
    // MARK: - coupon type buttons
    private let normalCouponButton = HPButton(cornerRadius: 13, borderColor: HPCommonUIAsset.couponTypeButtonTint.color.cgColor.copy(alpha: 0.5)).then {
        $0.setTitle("이용권", for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.setTitleColor(HPCommonUIAsset.couponTypeButtonTint.color, for: .normal)
        $0.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
    }
    private let loopPassCouponButton = HPButton(cornerRadius: 13, borderColor: HPCommonUIAsset.couponTypeButtonTint.color.cgColor.copy(alpha: 0.5)).then {
        $0.setTitle("루프패스", for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.setTitleColor(HPCommonUIAsset.couponTypeButtonTint.color, for: .normal)
        $0.snp.makeConstraints {
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
    }
    private lazy var categoryButtonsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    // MARK: - coupon list
    private let couponListView = CouponListView(coupons: [
        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date())
    ], withPageControl: false)
    
    // MARK: - 이용권 시작일 설정 버튼
    private let setCouponStartDateButton = UIButton().then {
        let label = UILabel()
        label.text = "이용권 시작일 설정하기"
        label.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        label.textColor = HPCommonUIAsset.underlinedButtonTitle.color
        
        let arrowImageView = UIImageView(image: HPCommonUIAsset.rightLongArrow.image)
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(6)
        }
        
        let underline = UIView()
        underline.backgroundColor = HPCommonUIAsset.buttonUnderline.color
        
        [label, arrowImageView, underline].forEach($0.addSubview(_:))
        
        label.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(12)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.bottom.equalTo(label.snp.bottom)
            $0.leading.equalTo(label.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
        }
        
        underline.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - 이용내역 부분
    private let historyTitleLabel = UILabel().then {
        $0.text = "이용내역"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private let prevMonthButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.leftPolygon.image, for: .normal)
        $0.tintColor = .black
        $0.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(10)
        }
    }
    
    private let monthLabel = UILabel().then {
        $0.text = "9월"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
    }
    
    private let nextMonthButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.rightPolygon.image, for: .normal)
        $0.tintColor = HPCommonUIAsset.deepSeparator.color
        $0.snp.makeConstraints {
            $0.width.equalTo(15)
            $0.height.equalTo(10)
        }
        $0.isEnabled = false
    }
    
    private lazy var monthControlStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
        
        [prevMonthButton, monthLabel, nextMonthButton].forEach($0.addArrangedSubview(_:))
    }
    
    private lazy var historyTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.rowHeight = CouponUsageHistoryCell.height
        $0.register(CouponUsageHistoryCell.self, forCellReuseIdentifier: CouponUsageHistoryCell.identifier)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layoutCouponTypeButtons()
        layoutCouponListView()
        layoutSetStartDateButton()
        layoutCouponUsageHistoryPart()
    }
    
    // MARK: - layout methods
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "내 이용권"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layoutCouponTypeButtons() {
        [normalCouponButton, loopPassCouponButton].forEach(categoryButtonsStack.addArrangedSubview(_:))
        view.addSubview(categoryButtonsStack)
        categoryButtonsStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func layoutCouponListView() {
        view.addSubview(couponListView)
        couponListView.snp.makeConstraints {
            $0.top.equalTo(categoryButtonsStack.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(170)
        }
    }
    
    private func layoutSetStartDateButton() {
        view.addSubview(setCouponStartDateButton)
        setCouponStartDateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(couponListView.snp.bottom).offset(38)
        }
    }
    
    private func layoutCouponUsageHistoryPart() {
        [historyTitleLabel, monthControlStack, historyTableView].forEach(view.addSubview(_:))
        historyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(setCouponStartDateButton.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(41)
        }
        
        monthControlStack.snp.makeConstraints {
            $0.top.equalTo(historyTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(41)
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(monthControlStack.snp.bottom).offset(30)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - table view data source
extension UserCouponHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponUsageHistoryCell.identifier) as! CouponUsageHistoryCell
        
        return cell
    }
}
