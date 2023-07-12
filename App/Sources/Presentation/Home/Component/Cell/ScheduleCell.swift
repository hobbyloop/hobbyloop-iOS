//
//  ScheduleCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/12.
//

import UIKit

import HPCommonUI
import Then


final class ScheduleCell: UICollectionViewCell {
    
    //MARK: Property
    private let nickNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        $0.numberOfLines = 1
    }
    
    /// 터치 영역이 정해지면 Button 으로 변경
    private let scheduleTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 18)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    
    private func configure() {
        
        [nickNameLabel, scheduleTitleLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(25)
        }
        
        
        
    }
    
    
}
