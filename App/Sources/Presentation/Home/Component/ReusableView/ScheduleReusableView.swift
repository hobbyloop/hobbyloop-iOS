//
//  ScheduleReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/17.
//

import UIKit

import HPCommonUI
import SnapKit
import Then


final class ScheduleReusableView: UICollectionReusableView {
    
    
    //MARK: Property
    
    //TODO: 추후 Title User Name Bindig Code 추가
    private let nickNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        $0.text = "지원님, 반가워요!"
        $0.numberOfLines = 1
    }
    
    private let scheduleTitleLabel: UIButton = UIButton(configuration: .plain(), primaryAction: nil).then {
        $0.configuration?.image = HPCommonUIAsset.rightArrow.image
        $0.configuration?.imagePadding = 240
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "예약된 손님", attributes: [
            .foregroundColor: HPCommonUIAsset.black.color,
            .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 18)
        ]))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [nickNameLabel, scheduleTitleLabel].forEach {
            self.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        scheduleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalTo(nickNameLabel)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    
}
