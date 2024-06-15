//
//  SignUpViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPExtensions
import HPFoundation
import RxGesture
import RxSwift
import RxCocoa
import ReactorKit

public final class SignUpViewController: BaseViewController<SignUpViewReactor> {
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14))
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    // MARK: Property
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let containerView: UIView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
        $0.color = .gray
    }
    
    // MARK: - 인사 + 설명
    private let greetingLabel = UILabel().then {
        $0.text = "반가워요 회원님!"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "회원님의 정보를 입력하세요."
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    // MARK: - 이름 + 닉네임
    private let nameView = HPTitledInputView(
        title: "이름",
        isRequired: true,
        inputType: .text,
        placeholder: "회원님의 이름을 적어주세요"
    )
    
    private let nickNameView = HPTitledInputView(
        title: "닉네임",
        isRequired: false,
        inputType: .text,
        placeholder: "자신만의 닉네임을 지어보세요!"
    )
    
    // MARK: - 성별
    private let genederDescriptionLabel: UILabel = UILabel().then {
        $0.text = "성별 *"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .justified
        $0.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
            color: HPCommonUIAsset.primary.color,
            offset: 0
        )
    }
    
    private let genderOfManButton = HPNewButton(title: "남성", style: .bordered)
    private let genderOfGirlButton = HPNewButton(title: "여성", style: .bordered).then {
        $0.isSelected = false
    }
    
    private lazy var horizontalGenderStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    // MARK: - 생년월일
    private let birthDayView = HPTitledInputView(title: "생년월일", isRequired: true, inputType: .date, placeholder: "생년월일을 입력하세요.")
    
    // MARK: - 전화번호 입력 + 인증번호
    private let phoneAuthVStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
    }
    
    private let phoneHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .bottom
        $0.distribution = .fill
    }
    private let phoneView = HPTitledInputView(
        title: "전화번호 인증",
        isRequired: true,
        inputType: .number,
        placeholder: "-를 제외한 번호를 입력해주세요"
    )
    
    private let issueAuthCodeButton = HPNewButton(title: "인증번호 발송", style: .bordered)
    
    private let authCodeHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
        $0.isHidden = true
    }
    private let authCodeView = HPTextField().then {
        $0.placeholderText = "인증번호를 입력하세요"
        
    }
    private let verifyAuthCodeButton = HPNewButton(title: "인증확인", style: .bordered)
    
    // MARK: - 약관
    private let termTitleLabel = UILabel().then {
        $0.text = "약관 동의"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let allTermsCheckbox = HPCheckbox()
    private let allTermsLabel = UILabel().then {
        $0.text = "전체 동의"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let termDividerView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let receiveInfoCheckbox = HPCheckbox()
    private let receiveInfoLabel = UILabel().then {
        $0.text = "마케팅 수신 정보 동의 [선택]"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    private lazy var receiveInfoDetailButton = TermDetailButton()
    
    private let collectInfoCheckbox = HPCheckbox()
    private let collectInfoLabel = UILabel().then {
        $0.text = "마케팅 정보 수집 동의 [선택]"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    private lazy var collectInfoDetailButton = TermDetailButton()
    
    
    // MARK: - 설명 + 입력 완료 버튼
    private let modifyDescriptionLabel: UILabel = UILabel().then {
        $0.text = "입력 하신 정보들은 마이페이지에서 언제든 수정 가능해요."
        $0.textColor = HPCommonUIAsset.gray60.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let confirmButton = HPNewButton(title: "하비루프 시작", style: .primary)
    
    // MARK: - date picker & background
    private let datePickerView = UIDatePicker().then {
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
    
    // MARK: - init
    override init(reactor: SignUpViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function)
    }
    
    // MARK: LifeCycle
    public override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        configure()
    }
    
    public override func viewDidLayoutSubviews() {
        self.verifyAuthCodeButton.layer.cornerRadius = 10
    }
    
    // MARK: Configure
    private func configure() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.navigationItem.setHidesBackButton(true, animated: true)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        [genderOfManButton, genderOfGirlButton].forEach {
            horizontalGenderStackView.addArrangedSubview($0)
        }
        
        [greetingLabel, descriptionLabel, nameView, nickNameView,
         genederDescriptionLabel, horizontalGenderStackView,
         phoneAuthVStack, confirmButton, modifyDescriptionLabel, birthDayView,
         termTitleLabel, allTermsCheckbox, allTermsLabel, termDividerView,
         receiveInfoCheckbox, receiveInfoLabel, receiveInfoDetailButton,
         collectInfoCheckbox, collectInfoLabel, collectInfoDetailButton
        ].forEach {
            containerView.addSubview($0)
        }
        
        greetingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(greetingLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(nameView)
        }
        
        genederDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameView.snp.bottom).offset(24)
            $0.leading.equalTo(nameView)
        }
        
        horizontalGenderStackView.snp.makeConstraints {
            $0.top.equalTo(genederDescriptionLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(48)
        }
        
        birthDayView.snp.makeConstraints {
            $0.top.equalTo(horizontalGenderStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(nameView)
        }
        
        [phoneView, issueAuthCodeButton].forEach(phoneHStack.addArrangedSubview(_:))
        
        issueAuthCodeButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
        [authCodeView, verifyAuthCodeButton].forEach(authCodeHStack.addArrangedSubview(_:))
        authCodeHStack.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        [phoneHStack, authCodeHStack].forEach(phoneAuthVStack.addArrangedSubview(_:))
        phoneAuthVStack.snp.makeConstraints {
            $0.top.equalTo(birthDayView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(nameView)
        }
        
        verifyAuthCodeButton.snp.makeConstraints {
            $0.width.height.equalTo(issueAuthCodeButton)
        }
        
        termTitleLabel.snp.makeConstraints {
            $0.top.equalTo(phoneAuthVStack.snp.bottom).offset(24)
            $0.leading.equalTo(nameView)
        }
        
        allTermsCheckbox.snp.makeConstraints {
            $0.top.equalTo(termTitleLabel.snp.bottom).offset(12)
            $0.left.equalTo(nameView)
        }
        
        allTermsLabel.snp.makeConstraints {
            $0.leading.equalTo(allTermsCheckbox.snp.trailing).offset(6)
            $0.centerY.equalTo(allTermsCheckbox)
        }
        
        termDividerView.snp.makeConstraints {
            $0.top.equalTo(allTermsCheckbox.snp.bottom).offset(12)
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(nameView)
        }
        
        receiveInfoCheckbox.snp.makeConstraints {
            $0.top.equalTo(termDividerView.snp.bottom).offset(12)
            $0.leading.equalTo(nameView)
        }
        
        receiveInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(receiveInfoCheckbox.snp.trailing).offset(6)
            $0.centerY.equalTo(receiveInfoCheckbox)
        }
        
        receiveInfoDetailButton.snp.makeConstraints {
            $0.trailing.equalTo(nameView)
            $0.centerY.equalTo(receiveInfoCheckbox)
        }
        
        collectInfoCheckbox.snp.makeConstraints {
            $0.top.equalTo(receiveInfoCheckbox.snp.bottom).offset(6)
            $0.leading.equalTo(nameView)
        }
        
        collectInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(collectInfoCheckbox.snp.trailing).offset(6)
            $0.centerY.equalTo(collectInfoCheckbox)
        }
        
        collectInfoDetailButton.snp.makeConstraints {
            $0.trailing.equalTo(nameView)
            $0.centerY.equalTo(collectInfoCheckbox)
        }
        
        modifyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(collectInfoCheckbox.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(modifyDescriptionLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(48)
        }
        
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        backgroundView.addSubview(datePickerView)
        datePickerView.snp.makeConstraints {
            $0.width.equalTo(297)
            $0.height.equalTo(213)
            $0.center.equalToSuperview()
        }
        
        self.makeDismissKeyboardGesture()
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func TermDetailButton() -> UIButton {
        return UIButton().then {
            $0.setAttributedTitle(
                NSAttributedString(
                    string: "자세히",
                    attributes: [
                        .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                        .foregroundColor: HPCommonUIAsset.gray60.color,
                        .underlineStyle: NSUnderlineStyle.single.rawValue
                    ]
                ),
                for: []
            )
        }
    }
    
    public override func bind(reactor: SignUpViewReactor) {
        // MARK: - Reactor -> VC
        reactor.state
            .map { $0.isLoading }
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userName }
            .bind(to: nameView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userNickName }
            .bind(to: nickNameView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userGender == .male }
            .bind(to: genderOfManButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userGender == .female }
            .bind(to: genderOfGirlButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.userBirthDay }
            .bind(to: birthDayView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.phoneNumber }
            .bind(to: phoneView.textfield.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.showsAuthCodeView }
            .bind(to: authCodeHStack.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            reactor.state.map { $0.userName },
            reactor.state.map { $0.userBirthDay },
            reactor.state.map { $0.isVaildPhoneNumber }
        ).map {
            !$0.0.isEmpty && $0.1.isEmpty && $0.2
        }
        .bind(to: confirmButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.agreement1IsSelected && $0.agreement2IsSelected }
            .bind(to: allTermsCheckbox.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.agreement1IsSelected }
            .bind(to: receiveInfoCheckbox.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.agreement2IsSelected }
            .bind(to: collectInfoCheckbox.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { !$0.showsDatePickerView }
            .bind(to: backgroundView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // MARK: - VC -> Reactor
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nameView.textfield.rx.textChange
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .map { Reactor.Action.updateName($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nickNameView.textfield.rx.textChange
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .map { Reactor.Action.updateNickName($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        genderOfManButton.rx.tap
            .map { Reactor.Action.updateGender(.male) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        genderOfGirlButton.rx.tap
            .map { Reactor.Action.updateGender(.female) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthDayView.textfield.rx.textChange
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .map { Reactor.Action.updateBirthDay($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        phoneView.textfield.rx.textChange
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .map { Reactor.Action.updatePhoneNumber($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        issueAuthCodeButton.rx.tap
            .map { Reactor.Action.didTapIssueAuthCodeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        verifyAuthCodeButton.rx.tap
            .map { Reactor.Action.didTapVeirfyAuthCodeButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        allTermsCheckbox.rx.tap
            .map { Reactor.Action.didTapAllTermsCheckbox }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        receiveInfoCheckbox.rx.tap
            .map { Reactor.Action.didTapReceiveInfoCheckbox }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectInfoCheckbox.rx.tap
            .map { Reactor.Action.didTapCollectInfoCheckbox }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .map { Reactor.Action.didTapCreateUserButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthDayView.showDatePickerButton.rx.tap
            .map { Reactor.Action.didTapDatePickerButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .filter { [weak self] gesture in
                guard let self else { return false }
                let location = gesture.location(in: self.datePickerView)
                return !self.datePickerView.bounds.contains(location)
            }
            .map { _ in Reactor.Action.didTapBackgroundView }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        datePickerView.rx.date
            .map {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                
                return formatter.string(from: $0)
            }
            .map { Reactor.Action.updateBirthDay($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: - Reactor -> Reactor
        reactor.pulse(\.$kakaoUserEntity)
            .compactMap { $0?.kakaoAccount?.profile?.nickname }
            .map { Reactor.Action.updateName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$naverUserEntity)
            .compactMap { $0?.response?.name }
            .map { Reactor.Action.updateName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$kakaoUserEntity)
            .compactMap { $0?.kakaoAccount?.gender }
            .map { $0 == .Male ? HPGender.male : HPGender.female }
            .map { Reactor.Action.updateGender($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$naverUserEntity)
            .compactMap { $0?.response?.gender }
            .map { $0 == "여성" ? HPGender.female : HPGender.male }
            .map { Reactor.Action.updateGender($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$kakaoUserEntity)
            .map { Reactor.Action.updateBirthDay($0?.kakaoAccount?.legalBirthDate ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.zip(
            reactor.pulse(\.$naverUserEntity)
                .compactMap { $0?.response?.birthyear },
            reactor.pulse(\.$naverUserEntity)
                .compactMap { $0?.response?.birthday }
        )
        .map { "\($0).\($1.replacingOccurrences(of: "-", with: "."))" }
        .map { Reactor.Action.updateBirthDay($0) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
            
        
        reactor.pulse(\.$kakaoUserEntity)
            .map { Reactor.Action.updatePhoneNumber($0?.kakaoAccount?.phoneNumber ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$naverUserEntity)
            .compactMap { $0?.response?.mobile?.replacingOccurrences(of: "-", with: "") }
            .map { Reactor.Action.updatePhoneNumber($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
