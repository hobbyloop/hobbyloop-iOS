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
    
    //MARK: Property
    private let exerciseButton: UIButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.rightArrow.image
        $0.configuration?.imagePadding = 240
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "오늘은 이 운동 어때요?", attributes: [
            .foregroundColor: HPCommonUIAsset.black.color,
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
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
        self.addSubview(exerciseButton)
        
        exerciseButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
    }
    
    
}
