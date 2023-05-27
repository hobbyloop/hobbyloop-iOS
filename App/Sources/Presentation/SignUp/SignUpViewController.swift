//
//  SignUpViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPFoundation
import ReactorKit



final class SignUpViewController: BaseViewController<SignUpViewReactor> {
    
    
    private let descriptionLabel: UILabel = UILabel().then {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        $0.text = "반가워요 회원님!\n회원님의 정보를 입력 해주세요."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.attributedText(
            targetString: "반가워요 회원님!",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 22),
            color: HPCommonUIAsset.black.color,
            paragraphStyle: paragraphStyle,
            spacing: 10,
            aligment: .center
        )
    }
    
    private let nameView: SignUpInfoView = SignUpInfoView(titleType: .name)
    
    private let nickNameView: SignUpInfoView = SignUpInfoView(titleType: .nickname)
    
    private let genederDescriptionLabel: UILabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .justified
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
    
    private let birthDayView: SignUpInfoView = SignUpInfoView(titleType: .birthDay)
    
    private let phoneView: SignUpInfoView = SignUpInfoView(titleType: .phone)
    
    private let certificationButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.separator.color.cgColor
    ).then {
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.boldSeparator.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 15)
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
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        
        [descriptionLabel, nameView, nickNameView,
         genederDescriptionLabel, horizontalGenderStackView, birthDayView,
         phoneView, certificationButton].forEach {
            view.addSubview($0)
        }
        
        [genderOfManButton, genderOfGirlButton].forEach {
            horizontalGenderStackView.addArrangedSubview($0)
        }
        
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
        

    }
    
    
    override func bind(reactor: SignUpViewReactor) {}
}
