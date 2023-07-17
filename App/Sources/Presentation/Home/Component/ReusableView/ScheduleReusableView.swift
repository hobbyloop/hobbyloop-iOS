//
//  ScheduleReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/17.
//

import UIKit

import HPCommonUI
import Then


final class ScheduleReusableView: UICollectionReusableView {
    
    
    //MARK: Property
    private let nickNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        $0.numberOfLines = 1
    }
    
    private let scheduleTitleLabel: UIButton = UIButton(configuration: .plain(), primaryAction: nil).then {        
        $0.setTitle("예약된 손님", for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
}
