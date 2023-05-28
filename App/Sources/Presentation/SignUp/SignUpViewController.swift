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
import RxGesture
import ReactorKit



final class SignUpViewController: BaseViewController<SignUpViewReactor> {
    
    // MARK: Property
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
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        $0.setTitle("여", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
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
    
    private let birthDayPickerView: SignUpDatePickerView = SignUpDatePickerView().then {
        $0.isHidden = true
    }
    
    private let confirmButton: HPButton = HPButton(cornerRadius: 10).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.white.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
    }
    
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
    
    private func configure() {
        self.view.backgroundColor = .white
        
        [descriptionLabel, nameView, nickNameView,
         genederDescriptionLabel, horizontalGenderStackView, birthDayView,
         phoneView, certificationButton, modifyDescriptionLabel, confirmButton, birthDayPickerView].forEach {
            view.addSubview($0)
        }
        
        [genderOfManButton, genderOfGirlButton].forEach {
            horizontalGenderStackView.addArrangedSubview($0)
        }
        
        birthDayPickerView.backgroundColor = .white
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.height.equalTo(62)
            $0.centerX.equalToSuperview()
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(100)
        }
        
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(15)
            $0.left.height.right.equalTo(nameView)
        }
        
        genederDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(23)
            $0.height.equalTo(20)
        }
        
        horizontalGenderStackView.snp.makeConstraints {
            $0.top.equalTo(genederDescriptionLabel.snp.bottom).offset(10)
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
            $0.top.equalTo(horizontalGenderStackView.snp.bottom).offset(10)
            $0.left.height.right.equalTo(nameView)
            
        }
        
        phoneView.snp.makeConstraints {
            $0.top.equalTo(birthDayView.snp.bottom).offset(10)
            $0.left.height.equalTo(nameView)
            $0.right.equalTo(certificationButton.snp.left).offset(-8)
        }
        
        certificationButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(83)
            $0.top.equalTo(phoneView.textFiledView)
            $0.right.equalToSuperview().offset(-15)
        }
        
        modifyDescriptionLabel.snp.makeConstraints {
            $0.height.equalTo(13)
            $0.width.equalTo(250)
            $0.top.equalTo(phoneView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        birthDayPickerView.snp.makeConstraints {
            $0.top.equalTo(birthDayView.snp.bottom)
            $0.left.right.equalTo(birthDayView)
            $0.height.equalTo(0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(modifyDescriptionLabel.snp.bottom).offset(12)
            $0.left.right.equalTo(birthDayView)
            $0.height.equalTo(66)
        }
        

    }
    
    
    override func bind(reactor: SignUpViewReactor) {
        
        birthDayView.rx
            .tapGesture()
            .when(.recognized)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.didTapBirthDayButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        genderOfManButton
            .rx.tap
            .map { Reactor.Action.didTapGenderButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        genderOfGirlButton
            .rx.tap
            .map { Reactor.Action.didTapGenderButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isBirthDaySelected)
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { vc, isSelected in
                if isSelected {
                    vc.birthDayPickerView.isHidden = !isSelected
                    vc.birthDayView.textFiledView.setupRightImage(image: HPCommonUIAsset.uparrow.image)
                    vc.birthDayPickerView.didTapAnimation(constraints: 138)
                } else {
                    vc.birthDayPickerView.isHidden = isSelected
                    vc.birthDayView.textFiledView.setupRightImage(image: HPCommonUIAsset.downarrow.image)
                    vc.birthDayPickerView.didTapAnimation(constraints: 0)
                }
            }).disposed(by: disposeBag)
        
        birthDayPickerView.rx
            .value
            .skip(1)
            .asDriver(onErrorJustReturn: Date())
            .drive(onNext: { [weak self] date in
                guard let `self` = self else { return }
                self.birthDayView.textFiledView.text = date.convertToString()
            }).disposed(by: disposeBag)
        
    }
}
