//
//  ClassHistoryCell.swift
//  Hobbyloop
//
//  Created by 김남건 on 5/14/24.
//

import UIKit
import SnapKit
import HPCommonUI

final class ClassHistoryCell: UICollectionViewCell {
    static let identifier = "ClassHistoryCell"
    static let height: CGFloat = 148
    
    private let classTitleLabel = UILabel().then {
        $0.text = "6:1 체형교정 필라테스"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let cancelButton = UIButton().then {
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
        $0.backgroundColor = HPCommonUIAsset.primary.color.withAlphaComponent(0.2)
        $0.setTitle("취소가능", for: .normal)
        $0.setTitle("취소불가", for: .disabled)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12)
        $0.setTitleColor(HPCommonUIAsset.primary.color, for: .normal)
        $0.setTitleColor(HPCommonUIAsset.gray60.color, for: .disabled)
    }
    
    private let studioNameLabel = UILabel().then {
        $0.text = "필라피티 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let instructorNameLabel = UILabel().then {
        $0.text = "이민주 강사님"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let horizontalLineView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
    }
    
    private let clockImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.watch.image
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "2023.05.12 금"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let verticalLineView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray100.color
        $0.layer.cornerRadius = 0.5
        $0.clipsToBounds = true
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "20:00 - 20:50"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let dateTimeStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: 30, topRightRadius: 8, bottomLeftRadius: 8, bottomRightRadius: 8)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        contentView.layer.mask = maskLayer
        contentView.layer.backgroundColor = HPCommonUIAsset.gray20.color.cgColor
        contentView.clipsToBounds = true
    }
    
    private func layout() {
        [
            clockImageView,
            dateLabel,
            verticalLineView,
            timeLabel
        ].forEach(dateTimeStack.addArrangedSubview(_:))
        
        [
            classTitleLabel,
            cancelButton,
            studioNameLabel,
            instructorNameLabel,
            horizontalLineView,
            dateTimeStack
        ].forEach(contentView.addSubview(_:))
        
        classTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(28)
            $0.height.equalTo(16)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-27)
            $0.width.equalTo(69)
            $0.height.equalTo(28)
            $0.centerY.equalTo(classTitleLabel.snp.centerY)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(classTitleLabel.snp.bottom).offset(14)
            $0.leading.equalTo(classTitleLabel.snp.leading)
            $0.height.equalTo(14)
        }
        
        instructorNameLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(classTitleLabel.snp.leading)
            $0.height.equalTo(14)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.top.equalTo(instructorNameLabel.snp.bottom).offset(8)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        verticalLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        
        dateTimeStack.snp.makeConstraints {
            $0.top.equalTo(horizontalLineView.snp.bottom).offset(8)
            $0.leading.equalTo(classTitleLabel.snp.leading)
        }
    }
}
