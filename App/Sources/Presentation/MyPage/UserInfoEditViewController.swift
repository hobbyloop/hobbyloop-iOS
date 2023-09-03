//
//  UserInfoEditViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/03.
//

import UIKit
import HPCommon
import HPCommonUI

class UserInfoEditViewController: UIViewController {    
    private let nameInputView = SignUpInfoView(titleType: .name, filled: true).then {
        $0.titleLabel.text = "이름"
        $0.textFiledView.text = "김지원"
    }
    
    private let nickNameInputView = SignUpInfoView(titleType: .nickname, filled: true).then {
        $0.titleLabel.text = "닉네임"
        $0.textFiledView.text = "지원"
    }
    
    private let birthDayInputView = SignUpInfoView(titleType: .birthDay, filled: true).then {
        $0.titleLabel.text = "출생년도"
        $0.textFiledView.text = "1996년 12월 10일"
    }
    
    private let phoneNumberInputView = SignUpInfoView(titleType: .phone, filled: true).then {
        $0.titleLabel.text = "전화번호"
        $0.textFiledView.text = "010-1234-5678"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let inputStack = UIStackView()
        inputStack.axis = .vertical
        inputStack.alignment = .fill
        inputStack.spacing = 36.14
        
        [nameInputView, nickNameInputView, birthDayInputView, phoneNumberInputView].forEach(inputStack.addArrangedSubview(_:))
        
        view.addSubview(inputStack)
        
        inputStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
    }
}
