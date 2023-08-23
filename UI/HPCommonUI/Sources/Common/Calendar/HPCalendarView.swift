//
//  HPCalendarView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/07/27.
//

import UIKit

import Then
import SnapKit
import RxDataSources


public struct HPDay: Equatable {
    let date: Date
    let today: String
    let isPrevious: Bool
    let isNext: Bool
}


public protocol HPCalendarDelegateProxy {
    var currentMonth: Date? { get set }
    var calendarDays: [HPDay] { get }
}

public final class HPCalendarView: UIView, HPCalendarDelegateProxy {

    // MARK: Property
    private var calendarMonthLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private var previousButton: UIButton = UIButton(type: .custom).then {
        $0.setTitle("", for: .normal)
        $0.setImage(HPCommonUIAsset.previousArrow.image, for: .normal)
    }
    
    private var nextButton: UIButton = UIButton(type: .custom).then {
        $0.setTitle("", for: .normal)
        $0.setImage(HPCommonUIAsset.nextArrow.image, for: .normal)

    }
    
    private var calendarCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 35, height: 35)
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    }
    
    private lazy var calendarCollectionView: UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: calendarCollectionViewLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    public var currentMonth: Date?
    public var calendarDays: [HPDay] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        setNeedsMonthDay()
    }
    
    
    private func setNeedsMonthDay() {
        guard let initalMonthDay = Calendar.current.date(byAdding: .month, value: 0, to: Date()) else { return }
        let components = Calendar.current.dateComponents([.year, .month], from: initalMonthDay)
        
        print("setNeeds Month Day: \(components)")
        self.calendarMonthLabel.text = "\(initalMonthDay.month)월"
        self.addSubview(self.calendarMonthLabel)
        
        self.calendarMonthLabel.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    
    // MARK: 예약된 수업 캘린더 레이아웃 구성 함수
    private func createCalendarLayout() -> NSCollectionLayoutSection {
        
        let calendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.frame.size.width),
            heightDimension: .absolute(250)
        )
        
        let calendarLayoutItem = NSCollectionLayoutItem(
            layoutSize: calendarLayoutSize
        )
        
        let calendarLayoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: calendarLayoutSize,
            subitems: [calendarLayoutItem]
        )
        
        let calendarSectionHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.frame.size.width),
            heightDimension: .absolute(40)
        )
        
        
        let calendarLayoutSection = NSCollectionLayoutSection(group: calendarLayoutGroup)
        calendarLayoutSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: calendarSectionHeaderLayoutSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        
        return calendarLayoutSection
    }
    
    
    // MARK: 예약된 수업 사용자 티켓정보 레이아웃 구성 함수
    private func createTicketInfoLayout() -> NSCollectionLayoutSection {
        
        let ticketInfoLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.frame.size.width),
            heightDimension: .estimated(140)
        )
        
        let ticketInfoLayoutItem = NSCollectionLayoutItem(layoutSize: ticketInfoLayoutSize)
        
        let ticketInfoLayoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: ticketInfoLayoutSize,
            subitems: [ticketInfoLayoutItem]
        )
        
        
        let ticketInfoLayoutSection = NSCollectionLayoutSection(group: ticketInfoLayoutGroup)
        
        return ticketInfoLayoutSection
    }
    
}



