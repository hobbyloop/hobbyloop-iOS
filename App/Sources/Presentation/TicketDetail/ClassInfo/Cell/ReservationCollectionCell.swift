//
//  ReservationCollectionCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/23.
//

import UIKit

import HPCommon
import HPCommonUI

class ReservationCollectionCell: UICollectionViewCell {
    private lazy var mainImageView: UIImageView = UIImageView()
    
    private lazy var titleView: UIView = UIView()
    
    private lazy var titleStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    
    private lazy var titleImageView: UIImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.font = UIFont().fontWithName(type: .bold, size: 14)
    }
    
    private lazy var starReview: StarReviewView = StarReviewView()
    
    private lazy var teacherName: UILabel = UILabel().then {
        $0.font = UIFont().fontWithName(type: .light, size: 10)
    }
    
    private lazy var teachingDetail: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont().fontWithName(type: .regular, size: 11)
        $0.lineBreakStrategy = .hangulWordPriority
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        [mainImageView, titleView, teacherName, teachingDetail].forEach {
            addSubview($0)
        }
        
        [titleImageView, titleLabel].forEach {
            titleStack.addArrangedSubview($0)
        }
        
        [titleStack, starReview].forEach {
            titleView.addSubview($0)
        }
        
        mainImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(128)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(13)
        }
        
        titleStack.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        starReview.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        teacherName.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleView)
            $0.top.equalTo(titleView.snp.bottom).offset(8)
        }
        
        teachingDetail.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleView)
            $0.top.equalTo(teacherName.snp.bottom).offset(10)
//            $0.bottom.equalToSuperview().inset(19)
        }
        
        
    }
    
    public func configure(_ detail: String) {
        layer.masksToBounds = true
        layer.borderColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 0.1).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        mainImageView.image = UIImage(named: "TicketTestImage")
        titleImageView.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
        titleLabel.text = "6:1 코어다지기"
        teacherName.text = "윤지영 강사"
        teachingDetail.text = detail
        starReview.configure(4.8)
    }
}
