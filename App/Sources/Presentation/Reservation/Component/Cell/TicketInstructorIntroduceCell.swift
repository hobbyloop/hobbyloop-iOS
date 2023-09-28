//
//  TicketInstructorIntroduceCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/28.
//

import UIKit

import SnapKit
import Then
import HPCommonUI



public final class TicketInstructorIntroduceCell: UICollectionViewCell {
    
    private let sportsTypeImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.yogaFilled.image
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.text = "윤지연 강사님"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textAlignment = .left
    }
    
    private let profileButton: UIButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.downarrow.image, for: .normal)
        $0.setImage(HPCommonUIAsset.uparrow.image, for: .selected)
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.imagePadding = 3
        $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "강사 프로필", attributes: [
            .foregroundColor: HPCommonUIAsset.black.color,
            .font : HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        ]))
        
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [sportsTypeImageView, nameLabel, profileButton].forEach {
            self.contentView.addSubview($0)
        }
        
        sportsTypeImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(14)
            $0.height.equalTo(21)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(sportsTypeImageView.snp.right).offset(10)
            $0.height.equalTo(21)
            $0.centerY.equalTo(sportsTypeImageView)
            $0.right.lessThanOrEqualTo(profileButton.snp.left).offset(-10)
        }
        
        profileButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(17)
            $0.centerY.equalTo(sportsTypeImageView)
            
        }
        
        
    }
    
}
