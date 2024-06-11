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
    
    private let certificationButton = HPNewButton(title: "인증번호 발송", style: .bordered)
    
    private let authHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fill
        $0.isHidden = true
    }
    private let authCodeView = HPTextField().then {
        $0.placeholderText = "인증번호를 입력하세요"
        
    }
    private let authCodeButton = HPNewButton(title: "인증확인", style: .bordered)
    
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
        self.authCodeButton.layer.cornerRadius = 10
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
        
        [phoneView, certificationButton].forEach(phoneHStack.addArrangedSubview(_:))
        
        certificationButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
        [authCodeView, authCodeButton].forEach(authHStack.addArrangedSubview(_:))
        authHStack.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        [phoneHStack, authHStack].forEach(phoneAuthVStack.addArrangedSubview(_:))
        phoneAuthVStack.snp.makeConstraints {
            $0.top.equalTo(birthDayView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(nameView)
        }
        
        authCodeButton.snp.makeConstraints {
            $0.width.height.equalTo(certificationButton)
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
        
        self.makeDismissKeyboardGesture()
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
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
        
//        Observable.just(())
//            .map { Reactor.Action.viewDidLoad }
//            .observe(on: MainScheduler.asyncInstance)
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        birthDayView
//            .rx.tapGesture()
//            .when(.recognized)
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .bind(onNext: { vc, _ in
//                vc.showBottomSheetView()
//            }).disposed(by: disposeBag)
//        
//        genderOfManButton
//            .rx.tap
//            .map { Reactor.Action.didTapGenderButton(.male) }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        genderOfGirlButton
//            .rx.tap
//            .map { Reactor.Action.didTapGenderButton(.female) }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        
//        reactor.state
//            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
//            .filter { $0.userGender == .male }
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfManButton.isSelected = true
//                self.genderOfGirlButton.isSelected = false
//                HapticUtil.impact(.light).generate()
//            }).disposed(by: disposeBag)
//        
//        reactor.state
//            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
//            .filter {  $0.userGender == .female }
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfGirlButton.isSelected = true
//                self.genderOfManButton.isSelected = false
//                HapticUtil.impact(.light).generate()
//            }).disposed(by: disposeBag)
//        
//        
//        reactor.state
//            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
//            .filter {  $0.userGender != .male }
//            .map { _ in HPCommonUIAsset.separator.color.cgColor }
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color.cgColor)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfManButton.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
//                self.genderOfManButton.layer.borderColor = color
//            }).disposed(by: disposeBag)
//        
//        
//        reactor.state
//            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
//            .filter {  $0.userGender != .female }
//            .map { _ in HPCommonUIAsset.separator.color.cgColor }
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color.cgColor)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfGirlButton.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
//                self.genderOfGirlButton.layer.borderColor = color
//            }).disposed(by: disposeBag)
//
//        
//        
////        reactor.pulse(\.$kakaoUserEntity)
////            .compactMap { $0?.kakaoAccount?.profile?.nickname}
////            .filter { !($0?.isEmpty ?? false) }
////            .observe(on: MainScheduler.asyncInstance)
////            .asDriver(onErrorJustReturn: "")
////            .drive(nameView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//        
//        reactor.pulse(\.$kakaoUserEntity)
//            .compactMap { $0?.kakaoAccount?.gender }
//            .filter { $0.rawValue == "male" }
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfManButton.isSelected = true
//                self.genderOfGirlButton.isEnabled = false
//            }).disposed(by: disposeBag)
//        
//        reactor.pulse(\.$kakaoUserEntity)
//            .compactMap { $0?.kakaoAccount?.gender }
//            .filter { $0.rawValue == "female" }
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .observe(on: MainScheduler.asyncInstance)
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfGirlButton.isSelected = true
//                self.genderOfManButton.isEnabled = false
//            }).disposed(by: disposeBag)
//        
//        
//        reactor.pulse(\.$kakaoUserEntity)
//            .compactMap { $0?.kakaoAccount?.gender }
//            .filter { $0.rawValue == "male" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in Reactor.Action.didTapGenderButton(.male)}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        reactor.pulse(\.$kakaoUserEntity)
//            .compactMap { $0?.kakaoAccount?.gender }
//            .filter { $0.rawValue == "female" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in Reactor.Action.didTapGenderButton(.female)}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
////        reactor.pulse(\.$naverUserEntity)
////            .filter { $0?.response != nil }
////            .compactMap { $0?.response }
////            .map { $0.name }
////            .observe(on: MainScheduler.asyncInstance)
////            .asDriver(onErrorJustReturn: "")
////            .drive(nameView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//        
//
//        reactor.pulse(\.$naverUserEntity)
//            .filter { $0?.response != nil }
//            .compactMap { $0?.response }
//            .filter { $0.gender == "M" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfManButton.isSelected = true
//            }).disposed(by: disposeBag)
//        
//        reactor.pulse(\.$naverUserEntity)
//            .filter { $0?.response != nil }
//            .compactMap { $0?.response }
//            .filter { $0.gender == "F" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in HPCommonUIAsset.deepOrange.color}
//            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
//            .drive(onNext: { [weak self] color in
//                guard let `self` = self else { return }
//                self.genderOfManButton.isSelected = true
//            }).disposed(by: disposeBag)
//        
//        
//        reactor.pulse(\.$naverUserEntity)
//            .filter { $0?.response != nil }
//            .compactMap { $0?.response }
//            .filter { $0.gender == "M" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in Reactor.Action.didTapGenderButton(.male)}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        reactor.pulse(\.$naverUserEntity)
//            .filter { $0?.response != nil }
//            .compactMap { $0?.response }
//            .filter { $0.gender == "F" }
//            .observe(on: MainScheduler.asyncInstance)
//            .map { _ in Reactor.Action.didTapGenderButton(.female)}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
////        reactor.pulse(\.$naverUserEntity)
////            .filter { $0?.response != nil }
////            .compactMap { $0?.response }
////            .map { $0.mobile }
////            .observe(on: MainScheduler.asyncInstance)
////            .asDriver(onErrorJustReturn: "")
////            .drive(phoneView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//
//
////        Observable.zip(
////            reactor.state.compactMap { $0.naverUserEntity?.response?.birthday },
////            reactor.state.compactMap { $0.naverUserEntity?.response?.birthyear }
////        ).filter { !$0.0.isEmpty && !$0.1.isEmpty  }
////            .map { "\($0.1+"-"+$0.0)".birthdayToString() }
////            .take(1)
////            .asDriver(onErrorJustReturn: "")
////            .drive(birthDayView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//        
//        
////        Observable.zip(
////            reactor.state.compactMap { $0.naverUserEntity?.response?.birthday },
////            reactor.state.compactMap { $0.naverUserEntity?.response?.birthyear }
////        ).filter { !$0.0.isEmpty && !$0.1.isEmpty }
////            .map { "\($0.1+"-"+$0.0)".birthdayToString() }
////            .take(1)
////            .asDriver(onErrorJustReturn: "")
////            .drive(birthDayView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//            
//
//        NotificationCenter.default
//            .rx.notification(UIResponder.keyboardWillShowNotification)
//            .compactMap { $0.userInfo }
//            .map { userInfo -> CGFloat in
//                return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
//            }
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe(onNext: { owner, height in
//                if owner.phoneView.textFieldView.isEditing {
//                    owner.containerView.frame.origin.y -= height
//                }
//            }).disposed(by: disposeBag)
//        
//        
//        NotificationCenter.default
//            .rx.notification(UIResponder.keyboardWillHideNotification)
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.containerView.frame.origin.y = 0
//            }).disposed(by: disposeBag)
//
//
//    
//        
////        reactor.state
////            .compactMap { $0.applefullName }
////            .filter { !$0.isEmpty }
////            .asDriver(onErrorJustReturn: "")
////            .drive(nameView.textFieldView.rx.text)
////            .disposed(by: disposeBag)
//        
//        
////        nameView.textFieldView
////            .rx.textChange
////            .distinctUntilChanged()
////            .observe(on: MainScheduler.instance)
////            .map { Reactor.Action.updateToName($0 ?? "") }
////            .bind(to: reactor.action)
////            .disposed(by: disposeBag)
//        
//        nickNameView.textFieldView
//            .rx.textChange
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .map { Reactor.Action.updateToNickName($0 ?? "")}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//
////        birthDayView.textFieldView
////            .rx.textChange
////            .distinctUntilChanged()
////            .observe(on: MainScheduler.asyncInstance)
////            .map { Reactor.Action.updateToBirthDay($0 ?? "")}
////            .bind(to: reactor.action)
////            .disposed(by: disposeBag)
//        
//        phoneView.textFieldView
//            .rx.textChange
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .map { Reactor.Action.updateToPhoneNumber($0 ?? "")}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        phoneView.textFieldView
//            .rx.textChange
//            .distinctUntilChanged()
//            .map { $0?.count ?? 0 == 13 }
//            .skip(1)
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .bind(onNext: { (owner, isEnabled) in
//                if isEnabled {
//                    owner.certificationButton.isEnabled = isEnabled
//                } else {
//                    owner.certificationButton.layer.borderColor = HPCommonUIAsset.separator.color.cgColor
//                    owner.certificationButton.isEnabled = isEnabled
//                    owner.hideDropdownAnimation()
//                }
//            }).disposed(by: disposeBag)
//        
//        
//        certificationButton
//            .rx.tap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withUnretained(self)
//            .bind(onNext: { owner, _ in
//                HapticUtil.impact(.light).generate()
//                owner.certificationButton.isSelected = true
//                owner.showDropdownAnimation()
//            }).disposed(by: disposeBag)
//        
//        reactor.state
//            .map { $0.phoneNumber }
//            .filter { $0.count == 11 }
//            .map { $0.toPhoneNumber() }
//            .observe(on: MainScheduler.asyncInstance)
//            .bind(to: phoneView.textFieldView.rx.text)
//            .disposed(by: disposeBag)
//            
//        phoneView.textFieldView
//            .rx.textChange
//            .filter { !($0?.count ?? 0 <= 12) }
//            .skip(1)
//            .map { _ in Reactor.Action.didChangePhoneNumber}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        
//        certificationButton
//            .rx.tap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .map { Reactor.Action.didTapCertificationButton }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        
//        reactor.state
//            .filter { $0.ceritifcationState == false }
//            .map { $0.ceritifcationState }
//            .observe(on: MainScheduler.instance)
//            .bind(to: certificationButton.rx.isSelected)
//            .disposed(by: disposeBag)
//        
//        phoneView.textFieldView
//            .rx.text.orEmpty
//            .scan("") { previous, new -> String in
//                if new.count > 13 {
//                  return previous
//                } else {
//                  return new
//                }
//              }
//            .bind(to: phoneView.textFieldView.rx.text)
//            .disposed(by: disposeBag)
//        
////        nameView
////            .textFieldView.rx.textChange
////            .distinctUntilChanged()
////            .compactMap { $0?.isEmpty ?? false || $0?.filter { $0.isNumber }.count ?? 0 >= 1 }
////            .skip(1)
////            .withUnretained(self)
////            .bind(onNext: { owner, isError in
////                owner.nameView.isError = isError
////                if isError {
////                    owner.nameView.snp.remakeConstraints {
////                        $0.bottom.equalTo(owner.nickNameView.snp.top).offset(-36)
////                        $0.left.equalToSuperview().offset(15)
////                        $0.right.equalToSuperview().offset(-15)
////                        $0.height.equalTo(110)
////                    }
////                } else {
////                    owner.nameView.snp.remakeConstraints {
////                        $0.bottom.equalTo(owner.nickNameView.snp.top).offset(-36)
////                        $0.left.equalToSuperview().offset(15)
////                        $0.right.equalToSuperview().offset(-15)
////                        $0.height.equalTo(80)
////                    }
////                }
////            }).disposed(by: disposeBag)
//        
//        
//        Observable
//            .combineLatest(
//                reactor.state.map { $0.userName },
//                reactor.state.map { $0.userGender },
//                reactor.state.map { $0.userBirthDay },
//                reactor.state.map { $0.phoneNumber }
//            ).map { !$0.0.isEmpty && !$0.1.getGenderType().isEmpty && !$0.2.isEmpty && !$0.3.isEmpty }
//            .bind(to: confirmButton.rx.isConfirm)
//            .disposed(by: disposeBag)
//        
//        
//        confirmButton
//            .rx.tap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .map { [weak self] in Reactor.Action.didTapCreateUserButton(self?.reactor?.currentState.userName ?? "", self?.reactor?.currentState.userNickName ?? "", self?.reactor?.currentState.userGender.getGenderType() ?? "", self?.reactor?.currentState.userBirthDay.birthdayDashSymbolToString() ?? "", self?.reactor?.currentState.phoneNumber ?? "")}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
//        
//        
//        reactor.state
//            .filter { $0.userAccountEntity?.statusCode == 201 }
//            .bind(onNext: { _ in
//                guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
//                scene.window?.rootViewController = CustomTabBarController()
//                scene.window?.makeKeyAndVisible()
//            }).disposed(by: disposeBag)
//        
//    
    }
}
