//
//  OnboardingCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import UIKit

import HPCommonUI
import ReactorKit
import Then
import SnapKit

final class OnboardingCell: UICollectionViewCell {
    
    // MARK: Property
    typealias Reactor = OnboardingCellReactor
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    private var onboardingTitleLabel: UILabel = UILabel().then {
        $0.text = "간단한 예약 방법"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 24)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private lazy var pageViewControl: HPPageControl = HPPageControl()
    
    private var onboardingImage: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }

        
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
    }
    
    
    
    
}



extension OnboardingCell: ReactorKit.View {
    
    
    func bind(reactor: Reactor) {
        
        
        
    }
    
}
