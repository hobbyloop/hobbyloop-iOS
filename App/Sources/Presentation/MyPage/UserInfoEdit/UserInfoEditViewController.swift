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
    
    // MARK: - custom navigation bar
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.text = "내 정보 수정"
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
    
    // MARK: - 사진 UI 및 사진 수정 버튼
    private let photoView = UIImageView.circularImageView(radius: 38)
    private let photoEditButton = UIButton().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HPCommonUIAsset.white.color.cgColor
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(red: 0xE7 / 255, green: 0xE7 / 255, blue: 0xE7 / 255, alpha: 1)
        $0.setImage(HPCommonUIAsset.plus.image, for: .normal)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    
    // MARK: - input view
    private let nameInputView = SignUpInfoView(titleType: .name, filled: true).then {
        $0.titleLabel.text = "이름"
        $0.textFieldView.text = "김지원"
    }
    
    private let nickNameInputView = SignUpInfoView(titleType: .nickname, filled: true).then {
        $0.titleLabel.text = "닉네임"
        $0.textFieldView.text = "지원"
    }
    
    private let birthDayInputView = SignUpInfoView(titleType: .birthDay, filled: true).then {
        $0.titleLabel.text = "출생년도"
        $0.textFieldView.text = "1996년 12월 10일"
    }
    
    private let phoneNumberInputView = SignUpInfoView(titleType: .phone, filled: true).then {
        $0.titleLabel.text = "전화번호"
        $0.textFieldView.text = "010-1234-5678"
    }
    
    // MARK: - calendar
    private let birthDayPickerView = SignUpDatePickerView().then {
        $0.isHidden = true
        $0.backgroundColor = .white
    }
    
    // MARK: - 수정완료 버튼
    private let confirmButton: HPButton = HPButton(cornerRadius: 10).then {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.white.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.backgroundColor = HPCommonUIAsset.mainColor.color
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let inputStack = UIStackView()
        inputStack.axis = .vertical
        inputStack.alignment = .fill
        inputStack.spacing = 36.14
        
        [nameInputView, nickNameInputView, birthDayInputView, phoneNumberInputView].forEach(inputStack.addArrangedSubview(_:))
        
        [customNavigationBar, photoView, photoEditButton, inputStack, confirmButton, birthDayPickerView].forEach(view.addSubview(_:))
        
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            $0.height.equalTo(56)
        }
        
        photoView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        photoEditButton.snp.makeConstraints {
            $0.trailing.equalTo(photoView.snp.trailing).offset(8)
            $0.bottom.equalTo(photoView.snp.bottom).offset(-7)
        }
        
        inputStack.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        birthDayPickerView.snp.makeConstraints {
            $0.top.equalTo(birthDayInputView.snp.bottom)
            $0.left.right.equalTo(birthDayInputView)
            $0.height.equalTo(0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleBirthDayPickerView))
        birthDayInputView.addGestureRecognizer(tapGesture)
        
        // TODO: text binding code를 delegate 패턴으로 수정
        birthDayPickerView.rx
            .value
            .skip(1)
            .asDriver(onErrorJustReturn: Date())
            .drive(onNext: { [weak self] date in
                guard let `self` = self else { return }
                self.birthDayInputView.textFieldView.text = date.convertToString()
            }).disposed(by: disposeBag)
    }
    
    @objc private func toggleBirthDayPickerView() {
        birthDayPickerView.isHidden.toggle()
        birthDayPickerView.didTapAnimation(constraints: birthDayPickerView.isHidden ? 0 : 138)
    }
}
