//
//  TicketTypeReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/10.
//

import UIKit

import HPCommonUI
import Then
import SnapKit


public final class TicketTypeReusableView: UICollectionReusableView {
    
    private let typeImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.ticket.image
    }
    
    private let typeTitleLabel: UILabel = UILabel().then {
        $0.text = "예약방법"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
        [typeImageView, typeTitleLabel].forEach {
            self.addSubview($0)
        }
        
        typeImageView.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.top.equalToSuperview().offset(17)
            $0.left.equalToSuperview().offset(16)
        }
        
        typeTitleLabel.snp.makeConstraints {
            $0.left.equalTo(typeImageView.snp.right).offset(6)
            $0.height.equalTo(19)
            $0.centerY.equalTo(typeImageView)
        }
        
    }
    
}


