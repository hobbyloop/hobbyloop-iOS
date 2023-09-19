//
//  UserCouponHistoryViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/19.
//

import UIKit
import HPCommonUI

final class UserCouponHistoryViewController: UIViewController {
    // MARK: - custom navigation bar
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.text = "내 이용권"
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
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutCustomNavigationBar()
        layoutCouponTypeButtons()
        layoutCouponListView()
        layoutSetStartDateButton()
    }
    
    // MARK: - layout methods
    private func layoutCustomNavigationBar() {
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            $0.height.equalTo(56)
        }
    }
    
    private func layoutCouponTypeButtons() {
        [normalCouponButton, loopPassCouponButton].forEach(categoryButtonsStack.addArrangedSubview(_:))
        view.addSubview(categoryButtonsStack)
        categoryButtonsStack.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(16)
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
}
