//
//  SignUpInfoView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

public enum SignUpType: String {
    case name = "이름"
    case nickname = "닉네임"
    case gender = "성별"
    case birthDay = "출생년도"
    case phone = "전화번호"
}


public final class SignUpInfoView: UIView {
    
    public private(set) var titleType: SignUpType
    
    
    
    public init(titleType: SignUpType) {
        self.titleType = titleType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
