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
    private lazy var exerciseButton: UIButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.rightArrow.image
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "오늘은 이 운동 어때요?", attributes: [
            .foregroundColor: HPCommonUIAsset.gray7.color,
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        ]))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.layoutIfNeeded()
        exerciseButton.configuration?.imagePadding = UIScreen.main.bounds.maxX - (80 + (exerciseButton.titleLabel?.frame.size.width ?? 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.addSubview(exerciseButton)
        self.backgroundColor = HPCommonUIAsset.whiteColor.color
        
        exerciseButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        }
        
        
    }
    
    
}
