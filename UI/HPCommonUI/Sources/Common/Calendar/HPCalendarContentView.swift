//
//  HPCalendarContentView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import UIKit

import HPFoundation
import SnapKit
import Then
import RxSwift
import RxCocoa


public final class HPCalendarContentView: UIView {
    
    private var disposeBag: DisposeBag = DisposeBag()
        
    public lazy var calendarMonthLabel: UILabel = UILabel().then {
        $0.text = "\(Date().month)월"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    public lazy var previousButton: UIButton = UIButton(type: .custom).then {
        $0.setTitle("", for: .normal)
        $0.setImage(HPCommonUIAsset.previousArrow.image, for: .normal)
    }
    
    public lazy var nextButton: UIButton = UIButton(type: .custom).then {
        $0.setTitle("", for: .normal)
        $0.setImage(HPCommonUIAsset.nextArrow.image, for: .normal)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        [calendarMonthLabel, previousButton, nextButton].forEach {
            self.addSubview($0)
        }
        
        
        calendarMonthLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(45)
            $0.height.equalTo(14)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        previousButton.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(17)
            $0.right.equalTo(calendarMonthLabel.snp.left).offset(-20)
            $0.centerY.equalTo(calendarMonthLabel)
        }
        
        
        nextButton.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(17)
            $0.left.equalTo(calendarMonthLabel.snp.right).offset(20)
            $0.centerY.equalTo(calendarMonthLabel)
        }
    }
    
}
