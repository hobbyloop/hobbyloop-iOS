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
import ReactorKit


private protocol SignUpViewAnimatable {
    @MainActor func dropdownAnimation()
    @MainActor func showBottomSheetView()
}



final class SignUpViewController: BaseViewController<SignUpViewReactor> {
    
    // MARK: Property
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let containerView: UIView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    
    private let descriptionLabel: UILabel = UILabel().then {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        $0.text = "반가워요 회원님!\n회원님의 정보를 입력 해주세요."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.setAttributedText(
            targetString: "반가워요 회원님!",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 22),
            color: HPCommonUIAsset.black.color,
            paragraphStyle: paragraphStyle,
            spacing: 10,
            aligment: .center
        )
    }
    
    private let nameView: SignUpInfoView = SignUpInfoView(titleType: .name).then {
        $0.titleLabel.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 11),
            color: HPCommonUIAsset.boldRed.color,
            offset: 8
        )
    }
    
    private let nickNameView: SignUpInfoView = SignUpInfoView(titleType: .nickname).then {
        $0.titleLabel.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 11),
            color: HPCommonUIAsset.boldRed.color,
            offset: 8
        )
    }
    
    private let genederDescriptionLabel: UILabel = UILabel().then {
        $0.text = "성별 *"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .justified
        $0.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 11),
            color: HPCommonUIAsset.boldRed.color,
            offset: 8
        )
    }
    
    private let genderOfManButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("남", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 15)
    }
    
    private let genderOfGirlButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("여", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 15)
    }
    
    private lazy var horizontalGenderStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let birthDayView: SignUpInfoView = SignUpInfoView(titleType: .birthDay).then {
        $0.titleLabel.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 11),
            color: HPCommonUIAsset.boldRed.color,
            offset: 8
        )
    }
    
    private let phoneView: SignUpInfoView = SignUpInfoView(titleType: .phone).then {
        $0.titleLabel.setSubScriptAttributed(
            targetString: "*",
            font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 11),
            color: HPCommonUIAsset.boldRed.color,
            offset: 8
        )
    }
    
    private let certificationButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 15)
    }
    
    private let modifyDescriptionLabel: UILabel = UILabel().then {
        $0.text = "입력 하신 정보들은 마이페이지에서 언제든 수정 가능해요."
        $0.textColor = HPCommonUIAsset.mediumSeparator.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 11)
        $0.textAlignment = .justified
        $0.numberOfLines = 1
    }

    
    private let confirmButton: HPButton = HPButton(cornerRadius: 10).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.white.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
    }
    
    
    private let authCodeView: SignUpInfoView = SignUpInfoView(titleType: .authcode)
    
    private let authCodeButton: HPButton = HPButton(
        cornerRadius: 0,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("인증확인", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 15)
    }
    
    private let termsView: SignUpTermsView = SignUpTermsView(reactor: SignUpTermsViewReactor())
    
    
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
    override func viewDidLoad() {
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        self.authCodeButton.layer.cornerRadius = 10
    }
    
    
    private func configure() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        
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
        
        [descriptionLabel, nameView, nickNameView,
         genederDescriptionLabel, horizontalGenderStackView, birthDayView,
         phoneView, certificationButton, authCodeView, authCodeButton, confirmButton, termsView, modifyDescriptionLabel].forEach {
            containerView.addSubview($0)
        }
        
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(62)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nameView.snp.top).offset(-36)
        }
        
        nameView.snp.makeConstraints {
            $0.bottom.equalTo(nickNameView.snp.top).offset(-36)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(100)
        }
        
        nickNameView.snp.makeConstraints {
            $0.bottom.equalTo(genederDescriptionLabel.snp.top).offset(-36)
            $0.left.height.right.equalTo(nameView)
        }
        
        genederDescriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(horizontalGenderStackView.snp.top).offset(-10)
            $0.top.equalTo(nickNameView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(23)
            $0.height.equalTo(20)
        }
        
        horizontalGenderStackView.snp.makeConstraints {
            $0.bottom.equalTo(birthDayView.snp.top).offset(-36)
            $0.left.equalTo(nickNameView)
            $0.width.equalTo(176)
            $0.height.equalTo(45)
        }
        
        genderOfManButton.snp.makeConstraints {
            $0.width.equalTo(84)
        }
        
        genderOfGirlButton.snp.makeConstraints {
            $0.width.equalTo(84)
        }
        
        birthDayView.snp.makeConstraints {
            $0.bottom.equalTo(phoneView.snp.top).offset(-36)
            $0.left.height.right.equalTo(nameView)
        }
        
        phoneView.snp.makeConstraints {
            $0.left.height.equalTo(nameView)
            $0.right.equalTo(certificationButton.snp.left).offset(-8)
            $0.bottom.equalTo(termsView.snp.top).offset(-36)
        }
        
        certificationButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(83)
            $0.bottom.equalTo(phoneView.textFiledView)
            $0.right.equalToSuperview().offset(-15)
        }
        
        termsView.snp.makeConstraints {
            $0.left.right.equalTo(nameView)
            $0.height.equalTo(160)
            $0.bottom.equalTo(modifyDescriptionLabel.snp.bottom).offset(-34)
        }
        
        modifyDescriptionLabel.snp.makeConstraints {
            $0.height.equalTo(13)
            $0.width.equalTo(250)
            $0.centerX.equalToSuperview()
        }
        
        authCodeView.snp.makeConstraints {
            $0.top.equalTo(phoneView.snp.bottom).offset(20)
            $0.left.right.equalTo(phoneView)
            $0.height.equalTo(0)
        }
        
        authCodeButton.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.width.equalTo(0)
            $0.top.equalTo(authCodeView.textFiledView)
            $0.right.equalToSuperview().offset(-15)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(modifyDescriptionLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview()
            $0.left.right.equalTo(birthDayView)
            $0.height.equalTo(66)
        }
        
        self.makeDismissKeyboardGesture()
        
    }
    
    
    override func bind(reactor: SignUpViewReactor) {
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthDayView
            .rx.tapGesture()
            .when(.recognized)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { vc, _ in
                vc.showBottomSheetView()
            }).disposed(by: disposeBag)
        
        genderOfManButton
            .rx.tap
            .map { Reactor.Action.didTapGenderButton(.male) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        genderOfGirlButton
            .rx.tap
            .map { Reactor.Action.didTapGenderButton(.female) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
            .filter { $0.userGender == .male }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfManButton.didTapHPButton(color)
                HapticUtil.impact(.light).generate()
            }).disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
            .filter {  $0.userGender == .female }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfGirlButton.didTapHPButton(color)
                HapticUtil.impact(.light).generate()
            }).disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
            .filter {  $0.userGender != .male }
            .map { _ in HPCommonUIAsset.separator.color.cgColor }
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color.cgColor)
            .drive(onNext: { color in
                self.genderOfManButton.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
                self.genderOfManButton.layer.borderColor = color
            }).disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.kakaoUserEntity == nil && $0.naverUserEntity == nil }
            .filter {  $0.userGender != .female }
            .map { _ in HPCommonUIAsset.separator.color.cgColor }
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color.cgColor)
            .drive(onNext: { color in
                self.genderOfGirlButton.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
                self.genderOfGirlButton.layer.borderColor = color
            }).disposed(by: disposeBag)

        
        // TODO: birthDayPickerView -> birthDayBottomSheet 로 디자인 변경
//        birthDayPickerView.rx
//            .value
//            .skip(1)
//            .asDriver(onErrorJustReturn: Date())
//            .drive(onNext: { [weak self] date in
//                guard let `self` = self else { return }
//                self.birthDayView.textFiledView.text = date.convertToString()
//            }).disposed(by: disposeBag)
        
        reactor.pulse(\.$kakaoUserEntity)
            .compactMap { $0?.kakaoAccount?.profile?.nickname}
            .filter { !($0?.isEmpty ?? false) }
            .asDriver(onErrorJustReturn: "")
            .drive(nameView.textFiledView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$kakaoUserEntity)
            .compactMap { $0?.kakaoAccount?.gender }
            .filter { $0.rawValue == "male" }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfManButton.didTapHPButton(color)
            }).disposed(by: disposeBag)
        
        reactor.pulse(\.$kakaoUserEntity)
            .compactMap { $0?.kakaoAccount?.gender }
            .filter { $0.rawValue == "female" }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfGirlButton.didTapHPButton(color)
            }).disposed(by: disposeBag)
        
        
        reactor.pulse(\.$naverUserEntity)
            .filter { $0?.response != nil }
            .compactMap { $0?.response }
            .map { $0.name }
            .asDriver(onErrorJustReturn: "")
            .drive(nameView.textFiledView.rx.text)
            .disposed(by: disposeBag)
        

        reactor.pulse(\.$naverUserEntity)
            .filter { $0?.response != nil }
            .compactMap { $0?.response }
            .filter { $0.gender == "M" }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfManButton.didTapHPButton(color)
            }).disposed(by: disposeBag)
        
        reactor.pulse(\.$naverUserEntity)
            .filter { $0?.response != nil }
            .compactMap { $0?.response }
            .filter { $0.gender == "F" }
            .map { _ in HPCommonUIAsset.deepOrange.color}
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                self.genderOfManButton.didTapHPButton(color)
            }).disposed(by: disposeBag)
        
        reactor.pulse(\.$naverUserEntity)
            .filter { $0?.response != nil }
            .compactMap { $0?.response }
            .map { $0.mobile }
            .asDriver(onErrorJustReturn: "")
            .drive(phoneView.textFiledView.rx.text)
            .disposed(by: disposeBag)

        Observable.zip(
            reactor.state.compactMap { $0.naverUserEntity?.response?.birthday },
            reactor.state.compactMap { $0.naverUserEntity?.response?.birthyear }
        ).filter { !$0.0.isEmpty && !$0.1.isEmpty  }
            .map { "\($0.1+"-"+$0.0)".birthdayToString() }
            .take(1)
            .asDriver(onErrorJustReturn: "")
            .drive(birthDayView.textFiledView.rx.text)
            .disposed(by: disposeBag)
        
        
        // TODO: birthDayPickerView -> birthDayBottomSheet 로 디자인 변경
//        Observable.zip(
//            reactor.state.compactMap { $0.naverUserEntity?.response?.birthday },
//            reactor.state.compactMap { $0.naverUserEntity?.response?.birthyear }
//        ).filter { !$0.0.isEmpty && !$0.1.isEmpty }
//            .map { "\($0.1+"-"+$0.0)".birthdayToString().birthdayToDate() }
//            .take(1)
//            .asDriver(onErrorJustReturn: Date())
//            .drive(birthDayPickerView.rx.date)
//            .disposed(by: disposeBag)

        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo }
            .map { userInfo -> CGFloat in
                return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vc, height in
                if vc.phoneView.textFiledView.isEditing {
                    vc.containerView.frame.origin.y -= height
                }
            }).disposed(by: disposeBag)
        
        
        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillHideNotification)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.containerView.frame.origin.y = 0
            }).disposed(by: disposeBag)


        
        
        phoneView.textFiledView
            .rx.text
            .changed
            .filter { $0?.count == 11 }
            .debug("changed PhoneNumber")
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { phoneNumber in
                guard let phoneNumber else { return }
                self.phoneView.textFiledView.text = phoneNumber.toPhoneNumber()
            }).disposed(by: disposeBag)
        
        phoneView.textFiledView
            .rx.value
            .compactMap { $0?.count }
            .map { $0 <= 13 }
            .debug("max count PhoneNumber")
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { vc, isEditing in
                if vc.phoneView.textFiledView.text?.count ?? 0 < 13 {
                    vc.certificationButton.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
                    vc.certificationButton.layer.borderColor = HPCommonUIAsset.separator.color.cgColor
                }
                guard !isEditing else { return }
                vc.phoneView.textFiledView.text = String(vc.phoneView.textFiledView.text?.dropLast() ?? "" )
            }).disposed(by: disposeBag)
        
        
        
        certificationButton.rx.tap.asObservable()
            .withLatestFrom(
                phoneView.textFiledView.rx.text.values.asObservable()
            ).filter { $0?.count == 13 }
            .map {  _ in HPCommonUIAsset.deepOrange.color }
            .asDriver(onErrorJustReturn: HPCommonUIAsset.separator.color)
            .drive(onNext: { color in
                HapticUtil.impact(.light).generate()
                self.certificationButton.didTapHPButton(color)
                self.dropdownAnimation()
            }).disposed(by: disposeBag)
        
        
        
        reactor.state
            .compactMap { $0.applefullName }
            .filter { !$0.isEmpty }
            .asDriver(onErrorJustReturn: "")
            .drive(nameView.textFiledView.rx.text)
            .disposed(by: disposeBag)
        
        
        
    }
}



extension SignUpViewController: SignUpViewAnimatable {
    
    func dropdownAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = `self` else { return }
            self.authCodeView.snp.remakeConstraints {
                $0.left.right.equalTo(self.phoneView)
                $0.height.equalTo(48)
                $0.bottom.equalTo(self.termsView.snp.top).offset(-36)
            }
            
            self.authCodeButton.snp.updateConstraints {
                $0.width.equalTo(83)
                $0.height.equalTo(50)
            }
            
            
            self.phoneView.snp.remakeConstraints {
                $0.left.height.equalTo(self.nameView)
                $0.right.equalTo(self.certificationButton.snp.left).offset(-8)
                $0.bottom.equalTo(self.authCodeView.snp.top).offset(-10)
            }
            
            self.termsView.snp.remakeConstraints {
                $0.left.right.equalTo(self.nameView)
                $0.height.equalTo(160)
                $0.bottom.equalTo(self.modifyDescriptionLabel.snp.bottom).offset(-34)
            }
            
            self.view.layoutIfNeeded()
        })
    }
    
    
    func showBottomSheetView() {
        let signUpBottomSheetView = SignUpBottomSheetView()
        signUpBottomSheetView.modalPresentationStyle = .overFullScreen
        self.present(signUpBottomSheetView, animated: true)
    }
    
    
}
