//
//  TicketScheduleCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/26.
//

import UIKit

import Then
import SnapKit
import HPCommonUI

public final class TicketScheduleCell: UICollectionViewCell {
    
    //MARK: Property
    private let circleView: UIImageView = UIImageView.circularImageView(radius: 4).then {
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
    }
    
    private let dateLabel: UILabel = UILabel().then {
        $0.text = "10:00 - 10:50"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var scheduleView: ScheduleView = ScheduleView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - 32, height: 140))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [circleView, dateLabel, scheduleView].forEach {
            self.contentView.addSubview($0)
        }
        
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(27)
            $0.width.height.equalTo(5)
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(circleView.snp.right).offset(15)
            $0.height.equalTo(10)
            $0.centerY.equalTo(circleView)
        }
        
        scheduleView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    
}



public final class ScheduleView: UIView {
    
    
    private let nameLabel: UILabel = UILabel().then {
        $0.text = "필라테스 기초반"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let difficultyTitleLabel: UILabel = UILabel().then {
        $0.text = "수업 난이도 :"
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private let difficultyLabel: UILabel = UILabel().then {
        $0.text = "하"
        $0.textColor = HPCommonUIAsset.deepOrange.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let underLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.horizontalDivider.color
    }
    
    private let humanImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.myOutlined.image
        $0.contentMode = .scaleToFill
    }
    
    private let reservationLabel: UILabel = UILabel().then {
        $0.text = "예약 2/6명"
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .left
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
        $0.numberOfLines = 1
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createNoneImageTicketView(frame, backgroundColor: HPCommonUIAsset.systemBackground.color)
        configure()

       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        
        
        [nameLabel, difficultyTitleLabel, difficultyLabel, underLineView, humanImageView, reservationLabel].forEach {
            self.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalToSuperview().offset(37)
            $0.height.equalTo(19)
        }
        
        difficultyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(9)
            $0.left.equalTo(nameLabel)
            $0.height.equalTo(16)
        }
        
        difficultyLabel.snp.makeConstraints {
            $0.left.equalTo(difficultyTitleLabel.snp.right).offset(6)
            $0.height.equalTo(19)
            $0.centerY.equalTo(difficultyTitleLabel)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(difficultyTitleLabel.snp.bottom).offset(19)
            $0.left.equalToSuperview().offset(23)
            $0.right.equalToSuperview().offset(-18)
            $0.height.equalTo(1)
        }
        
        humanImageView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(16)
            $0.width.equalTo(17)
            $0.height.equalTo(18)
            $0.left.equalToSuperview().offset(39)
        }
        
        reservationLabel.snp.makeConstraints {
            $0.left.equalTo(humanImageView.snp.right).offset(12)
            $0.centerY.equalTo(humanImageView)
            $0.height.equalTo(17)
        }
    }
    
    
}

