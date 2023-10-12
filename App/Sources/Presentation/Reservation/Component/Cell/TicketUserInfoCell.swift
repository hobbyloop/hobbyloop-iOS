//
//  TicketUserInfoCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/11.
//

import UIKit

import HPCommon
import HPCommonUI

public final class TicketUserInfoCell: UICollectionViewCell {
    
    private let userNameView: SignUpInfoView = SignUpInfoView(titleType: .name, filled: true).then {
        $0.titleLabel.text = "이름"
        $0.textFieldView.text = "김지원"
        $0.textFieldView.isUserInteractionEnabled = false
    }
    
    private let userPhoneView: SignUpInfoView = SignUpInfoView(titleType: .phone, filled: true).then {
        $0.titleLabel.text = "전화번호"
        $0.textFieldView.text = "010-1234-5678"
        $0.textFieldView.isUserInteractionEnabled = false
    }
    
    private let confirmButton: HPButton = HPButton(cornerRadius: 10).then {
        $0.setTitle("예약하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.white.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [userNameView, userPhoneView, confirmButton].forEach {
            self.contentView.addSubview($0)
        }
        
        userNameView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(80)
        }
        
        userPhoneView.snp.makeConstraints {
            $0.top.equalTo(userNameView.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(80)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(userPhoneView.snp.bottom).offset(31)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
    }
    
}

