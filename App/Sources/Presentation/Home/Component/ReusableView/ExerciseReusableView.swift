//
//  ExerciseReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/19.
//

import UIKit

import HPCommonUI
import SnapKit
import Then


final class ExerciseReusableView: UICollectionReusableView {
    
    private let titleStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 6
    }
    
    private let iconImage: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
    }
    
    private let benefitsTitleLabel: UILabel = UILabel().then {
        $0.text = "헬스/PT 는 어떠세요?"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.setSubScriptAttributed(
            targetString: "헬스/PT",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18),
            color: HPCommonUIAsset.sub.color
        )
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let openButton: UIButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.downarrow.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [titleStack, openButton].forEach {
            self.addSubview($0)
        }
        
        [iconImage, benefitsTitleLabel].forEach {
            titleStack.addArrangedSubview($0)
        }
        
        [iconImage, openButton].forEach {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(26)
            }
        }
        
        titleStack.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        openButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
    }
    
    
}
