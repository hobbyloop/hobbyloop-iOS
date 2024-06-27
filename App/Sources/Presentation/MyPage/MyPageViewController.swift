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
import ReactorKit
import RxSwift

final class MyPageViewController: BaseViewController<MyPageViewReactor> {
    // MARK: - activity indicator
    private let activityIndicator = UIActivityIndicatorView()
    
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
    private lazy var pointButton = KeyValueButton(title: "포인트", subtitle: "50,000P")
    private lazy var ticketButton = KeyValueButton(title: "이용권", subtitle: "3개")
    private lazy var discountCouponButton = KeyValueButton(title: "쿠폰", subtitle: "2개")
    
    private let verticalButtonsDivider1 = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let verticalButtonsDivider2 = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let keyValueButtonsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let bottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 보관함, 리뷰, 수업내역 버튼
    private lazy var bookmarkButton = ArrowedButton(title: "보관함")
    private lazy var reviewButton = ArrowedButton(title: "리뷰", textColor: HPCommonUIAsset.gray40.color).then {
        $0.isEnabled = false
    }
    private lazy var classHistoryButton = ArrowedButton(title: "수업 내역")
    private let arrowedButtonsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .fill
    }
    
    // MARK: - init
    override init(reactor: MyPageViewReactor?) {
        super.init()
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
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
        
        [pointButton, ticketButton, discountCouponButton].forEach {
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
        ].forEach(keyValueButtonsStack.addArrangedSubview(_:))
        
        [bookmarkButton, reviewButton, classHistoryButton].forEach(arrowedButtonsStack.addArrangedSubview(_:))
        
        [
            profileImageView,
            nameEditStack,
            nicknamePhoneNumberStack,
            keyValueButtonsStack,
            bottomMarginView,
            arrowedButtonsStack,
            activityIndicator
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
        
        keyValueButtonsStack.snp.makeConstraints {
            $0.top.equalTo(nicknamePhoneNumberStack.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        
        bottomMarginView.snp.makeConstraints {
            $0.top.equalTo(keyValueButtonsStack.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        arrowedButtonsStack.snp.makeConstraints {
            $0.top.equalTo(bottomMarginView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let reactor else { return }
        
        Observable.just(())
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bind(reactor: MyPageViewReactor) {
        reactor.state
            .map { $0.isLoading }
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let myPageData = reactor.state
            .map { $0.data }
            .observe(on: MainScheduler.instance)
            .share()
        
        myPageData
            .map { $0.name }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageData
            .map { $0.nickname }
            .bind(to: nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.data.phoneNumber }
            .bind(to: phoneNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageData
            .map { $0.points }
            .subscribe(onNext: { [weak self] point in
                guard let self else { return }
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                guard let formattedPointString = numberFormatter.string(from: NSNumber(value: point)) else { return }
                self.pointButton.configuration?.attributedSubtitle = AttributedString.init("\(formattedPointString) P", attributes: .init([
                    .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                    .foregroundColor: HPCommonUIAsset.gray100.color
                ]))
            })
            .disposed(by: disposeBag)
        
        myPageData
            .map { $0.ticketCount }
            .subscribe(onNext: { [weak self] ticketCount in
                guard let self else { return }
                self.ticketButton.configuration?.attributedSubtitle = AttributedString.init("\(ticketCount)개", attributes: .init([
                    .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                    .foregroundColor: HPCommonUIAsset.gray100.color
                ]))
            })
            .disposed(by: disposeBag)
        
        myPageData
            .map { $0.couponCount }
            .subscribe(onNext: { [weak self] couponCount in
                guard let self else { return }
                self.discountCouponButton.configuration?.attributedSubtitle = AttributedString.init("\(couponCount)개", attributes: .init([
                    .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                    .foregroundColor: HPCommonUIAsset.gray100.color
                ]))
            })
            .disposed(by: disposeBag)
    }
}
