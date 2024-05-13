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

final class UserInfoEditViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        $0.configuration?.contentInsets = .init(top: 7, leading: 10, bottom: 7, trailing: 10)
    }
    
    private lazy var backButtonItem = UIBarButtonItem(customView: backButton)
    
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
    
    private let nameView: SignUpInfoView = SignUpInfoView(titleType: .name)
    private let nickNameView: SignUpInfoView = SignUpInfoView(titleType: .nickname)
    private let birthDayView: SignUpInfoView = SignUpInfoView(titleType: .birthDay)
    // TODO: picker view를 SignUpInfoView 안에 포함시키기
    private let birthDayPickerView = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.backgroundColor = .clear
        $0.locale = .init(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.backgroundColor = HPCommonUIAsset.gray20.color
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    private let phoneView: SignUpInfoView = SignUpInfoView(titleType: .phone)
    private let certificateButton = HPNewButton(title: "인증번호 발송", style: .bordered)
    private let phoneHStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .bottom
        $0.distribution = .fill
    }
    
    private let authCodeView: SignUpInfoView = SignUpInfoView(titleType: .authcode)
    private let authCodeButton = HPNewButton(title: "인증번호 확인", style: .bordered).then {
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
    
    private let editButton = HPNewButton(title: "수정완료", style: .primary).then {
        $0.isEnabled = false
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
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private func layout() {
        [phoneView, certificateButton].forEach(phoneHStack.addArrangedSubview(_:))
        
        authCodeButton.snp.makeConstraints {
            $0.width.equalTo(120)
        }
        
        [authCodeView, authCodeButton].forEach(authHStack.addArrangedSubview(_:))
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
            inputFieldsVStack,
            birthDayPickerView,
            editButton
        ].forEach(view.addSubview(_:))
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        photoEditButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(-7)
            $0.trailing.equalTo(profileImageView.snp.trailing).offset(7)
        }
        
        certificateButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
        inputFieldsVStack.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        birthDayPickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(birthDayView.snp.bottom).offset(4)
        }
        
        editButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-32)
            $0.height.equalTo(48)
        }
    }
}
