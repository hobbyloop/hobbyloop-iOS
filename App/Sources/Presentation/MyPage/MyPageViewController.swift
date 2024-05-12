//
//  MyPageViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/06/03.
//

import UIKit
import SnapKit
import HPCommonUI
import Then

final class MyPageViewController: UIViewController {
    // MARK: - 네비게이션 버튼
    private let settingsButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.settingOutlind.image, for: [])
        $0.tintColor = HPCommonUIAsset.gray100.color
    }
    
    private lazy var settingsButtonItem = UIBarButtonItem(customView: settingsButton)
    
    // MARK: - 프로필 파트 UI
    private let profileImageView = UIImageView.circularImageView(radius: 42.5).then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "본명"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let editProfileButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.pen.image, for: [])
        $0.tintColor = HPCommonUIAsset.gray60.color
    }
    
    private let nameEditStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray40.color
    }
    
    private let nicknamePhoneNumberDivider = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let phoneNumberLabel = UILabel().then {
        $0.text = "010-1234-5678"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray40.color
    }
    
    private let nicknamePhoneNumberStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 4
    }
    
    // MARK: - 포인트, 이용권, 쿠폰 파트 UI
    private lazy var pointButton = VerticalButton(title: "포인트", subtitle: "50,000P")
    private lazy var ticketButton = VerticalButton(title: "이용권", subtitle: "3개")
    private lazy var discountCouponButton = VerticalButton(title: "쿠폰", subtitle: "2개")
    
    private let verticalButtonsDivider1 = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let verticalButtonsDivider2 = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let verticalButtonsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layout()
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "마이페이지"
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
    
    private func layout() {
        [nameLabel, editProfileButton].forEach(nameEditStack.addArrangedSubview(_:))
        
        nicknamePhoneNumberDivider.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        [nicknameLabel, nicknamePhoneNumberDivider, phoneNumberLabel].forEach(nicknamePhoneNumberStack.addArrangedSubview(_:))
        [verticalButtonsDivider1, verticalButtonsDivider2].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(1)
                $0.height.equalTo(10)
            }
        }
        
        [ pointButton, ticketButton, discountCouponButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(100)
            }
        }
        
        [
            pointButton,
            verticalButtonsDivider1,
            ticketButton,
            verticalButtonsDivider2,
            discountCouponButton
        ].forEach(verticalButtonsStack.addArrangedSubview(_:))
        
        [
            profileImageView,
            nameEditStack,
            nicknamePhoneNumberStack,
            verticalButtonsStack
        ].forEach(view.addSubview(_:))
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        nameEditStack.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        nicknamePhoneNumberStack.snp.makeConstraints {
            $0.top.equalTo(nameEditStack.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        verticalButtonsStack.snp.makeConstraints {
            $0.top.equalTo(nicknamePhoneNumberStack.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
    }
    
    private func VerticalButton(title: String, subtitle: String) -> UIButton {
        return UIButton(configuration: .plain()).then {
            $0.configuration?.attributedTitle = AttributedString.init(title, attributes: .init([
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: HPCommonUIAsset.gray80.color
            ]))
            
            $0.configuration?.attributedSubtitle = AttributedString.init(subtitle, attributes: .init([
                .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                .foregroundColor: HPCommonUIAsset.gray100.color
            ]))
            
            $0.configuration?.titleAlignment = .center
            $0.configuration?.titlePadding = 10
            $0.configuration?.contentInsets = .zero
        }
    }
}
