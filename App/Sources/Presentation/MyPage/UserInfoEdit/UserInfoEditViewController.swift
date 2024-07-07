//
//  UserInfoEditViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/03.
//

import UIKit
import HPCommon
import HPCommonUI
import RxSwift
import RxGesture

final class UserInfoEditViewController: BaseViewController<UserInfoEditViewReactor> {
    
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        $0.configuration?.contentInsets = .init(top: 7, leading: 10, bottom: 7, trailing: 10)
    }
    
    private lazy var backButtonItem = UIBarButtonItem(customView: backButton)
    
    // MARK: - scroll view & container
    private let scrollView = UIScrollView()
    private let scrolledContainerView = UIView()
    
    // MARK: - 사진 UI 및 사진 수정 버튼
    private let profileImageView = UIImageView.circularImageView(radius: 42.5).then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    private let photoEditButton = UIButton().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HPCommonUIAsset.white.color.cgColor
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = HPCommonUIAsset.gray40.color
        $0.setImage(HPCommonUIAsset.plus.image, for: .normal)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    private let nameView = HPTitledInputView(
        title: "이름",
        isRequired: false,
        inputType: .text,
        placeholder: "회원님의 이름을 입력하세요"
    )
    private let nickNameView = HPTitledInputView(
        title: "닉네임",
        isRequired: false,
        inputType: .text,
        placeholder: "자신만의 닉네임을 입력하세요!"
    )
    private let birthDayView = HPTitledInputView(
        title: "생년월일",
        isRequired: false,
        inputType: .date,
        placeholder: "태어난 생년월일을 선택해주세요"
    )

    private let birthDayPickerView = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = .init(identifier: "ko-KR")
        $0.backgroundColor = UIColor(red: 0xB2, green: 0xB2, blue: 0xB2, alpha: 1)
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private let phoneView = HPTitledInputView(
        title: "전화번호 인증",
        isRequired: false,
        inputType: .number,
        placeholder: "-를 제외한 전화번호를 입력하세요"
    )
    private let issueAuthCodeButton = HPNewButton(title: "인증번호 발송", style: .bordered)
    private let phoneHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .bottom
        $0.distribution = .fill
    }
    
    private let authCodeView = HPTextField().then {
        $0.placeholderText = "인증번호를 입력하세요"
    }
    private let confirmAuthCodeButton = HPNewButton(title: "인증번호 확인", style: .bordered).then {
        $0.isEnabled = false
    }
    
    private let authHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let phoneAuthVStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.alignment = .fill
    }
    
    private let inputFieldsVStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
        $0.alignment = .fill
    }
    
    private let updateUserInfoButton = HPNewButton(title: "수정완료", style: .primary).then {
        $0.isEnabled = false
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - init
    override init(reactor: UserInfoEditViewReactor?) {
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
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "내 정보 수정"
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(scrolledContainerView)
        scrolledContainerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
        
        [phoneView, issueAuthCodeButton].forEach(phoneHStack.addArrangedSubview(_:))
        
        confirmAuthCodeButton.snp.makeConstraints {
            $0.width.equalTo(120)
        }
        
        [authCodeView, confirmAuthCodeButton].forEach(authHStack.addArrangedSubview(_:))
        
        authHStack.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        [phoneHStack, authHStack].forEach(phoneAuthVStack.addArrangedSubview(_:))
        
        [
            nameView,
            nickNameView,
            birthDayView,
            phoneView,
        ].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(76)
            }
        }
        
        [
            nameView,
            nickNameView,
            birthDayView,
            phoneAuthVStack
        ].forEach(inputFieldsVStack.addArrangedSubview(_:))
        
        [
            profileImageView,
            photoEditButton,
            inputFieldsVStack
        ].forEach(scrolledContainerView.addSubview(_:))
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
        
        photoEditButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(-7)
            $0.trailing.equalTo(profileImageView.snp.trailing).offset(7)
        }
        
        issueAuthCodeButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
        inputFieldsVStack.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-189)
        }
        
        view.addSubview(updateUserInfoButton)
        
        updateUserInfoButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-32)
            $0.height.equalTo(48)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(birthDayPickerView)
        birthDayPickerView.snp.makeConstraints {
            $0.width.equalTo(297)
            $0.height.equalTo(213)
            $0.center.equalToSuperview()
        }
    }
    
    override func bind(reactor: UserInfoEditViewReactor) {
        // MARK: - reactor -> view
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.isLoading }
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.name }
            .bind(to: nameView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.nickname }
            .bind(to: nickNameView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.birthday }
            .bind(to: birthDayView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.phoneNumber }
            .bind(to: phoneView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.authCode }
            .bind(to: authCodeView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { !$0.showsAuthCodeView }
            .bind(to: authHStack.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { !$0.isValidPhoneNumber }
            .bind(to: confirmAuthCodeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { !$0.isValidPhoneNumber }
            .bind(to: authCodeView.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.showsBirthdayPicker }
            .bind(to: backgroundView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // MARK: - view -> reactor
        Observable.of(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nameView.textfield.rx.text.orEmpty
            .map { Reactor.Action.updateName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nickNameView.textfield.rx.text.orEmpty
            .map { Reactor.Action.updateNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthDayPickerView.rx.date
            .map {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                
                return formatter.string(from: $0)
            }
            .map { Reactor.Action.updateBirthday($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        phoneView.textfield.rx.text.orEmpty
            .map { Reactor.Action.updatePhoneNumber($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        issueAuthCodeButton.rx.tap
            .map { Reactor.Action.tapIssueAuthCodeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        authCodeView.rx.text.orEmpty
            .map { Reactor.Action.updateAuthCode($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmAuthCodeButton.rx.tap
            .map { Reactor.Action.tapVerifyAuthCodeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        updateUserInfoButton.rx.tap
            .map { Reactor.Action.tapUpdateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthDayView.showDatePickerButton.rx.tap
            .map { Reactor.Action.tapBirthdayPickerButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .filter { [weak self] gesture in
                guard let self else { return false }
                let location = gesture.location(in: self.birthDayPickerView)
                return !self.birthDayPickerView.bounds.contains(location)
            }
            .map { _ in Reactor.Action.tapBackgroundView }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
