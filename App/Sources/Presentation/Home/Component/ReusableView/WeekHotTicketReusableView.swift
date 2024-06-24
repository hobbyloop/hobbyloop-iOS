//
//  WeekHotTicketReusableView.swift
//  Hobbyloop
//
//  Created by Kim JinWoo on 2024/06/09.
//

import UIKit

import HPCommonUI
import HPExtensions
import Then

final class WeekHotTicketReusableView: UICollectionReusableView {
    
    private let ticketStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 6
    }
    
    private let ticketImage: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
    }
    
    private let benefitsTitleLabel: UILabel = UILabel().then {
        $0.text = "이번주 HOT 이용권"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.setSubScriptAttributed(
            targetString: "HOT",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18),
            color: HPCommonUIAsset.sub.color
        )
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let openButton: UIButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.leftArrow.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [ticketStack, openButton].forEach {
            self.addSubview($0)
        }
        
        [ticketImage, benefitsTitleLabel].forEach {
            ticketStack.addArrangedSubview($0)
        }
        
        [ticketImage, openButton].forEach {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(26)
            }
        }
        
        ticketStack.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        openButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
    }
}


