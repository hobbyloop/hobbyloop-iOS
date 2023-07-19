//
//  ExerciseCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/19.
//

import UIKit

import HPCommonUI
import Then
import SnapKit

final class ExerciseCell: UICollectionViewCell {
    
    private let contentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    private let contentTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let contentSubTitleLable: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 23)
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    //TODO: content Design 추가
    
    
    //MARK: Property
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
