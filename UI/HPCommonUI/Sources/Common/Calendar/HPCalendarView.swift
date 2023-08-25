//
//  HPCalendarView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/07/27.
//

import UIKit


import RxDataSources
import ReactorKit
import Then
import SnapKit



public struct HPDay: Equatable {
    let date: Date
    let today: String
    let isPrevious: Bool
    let isNext: Bool
}
public final class HPCalendarView: UIView {

    // MARK: Property
    
    public var disposeBag: DisposeBag = DisposeBag()
    public typealias Reactor = HPCalendarViewReactor
    private lazy var calendarMonthLabel: UILabel = UILabel().then {
        $0.text = "\(Date().month)월"
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
    
    private lazy var calendarDataSource: RxCollectionViewSectionedReloadDataSource<CalendarSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case let .calendarItem(cellReactor):
            guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarDayCell", for: indexPath) as? HPCalendarDayCell else { return UICollectionViewCell() }
            calendarCell.reactor = cellReactor
            return calendarCell
            
        default:
            return UICollectionViewCell()
        }
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        let dataSource = dataSource[indexPath]
        
        switch dataSource {
        case .calendarItem:
            guard let weekDayReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HPCalendarWeekReusableView", for: indexPath) as? HPCalendarWeekReusableView else { return UICollectionReusableView() }
            
            return weekDayReusableView
            
        default:
            return UICollectionReusableView()
            
        }
        
    }

    
    private lazy var calendarCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        
        let section = self.calendarDataSource.sectionModels[section]
        
        switch section {
        case .calendar:
            return self.createCalendarLayout()
        case .ticket:
            return self.createTicketInfoLayout()
        }
        
    }
    
    
    
    private lazy var calendarCollectionView: UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: calendarCollectionViewLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(HPCalendarDayCell.self, forCellWithReuseIdentifier: "HPCalendarDayCell")
        $0.register(HPCalendarWeekReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HPCalendarWeekReusableView")
    }
    
    public init(reactor: HPCalendarViewReactor) {
        super.init(frame: .zero)
        self.reactor = reactor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        
        self.backgroundColor = .white
        
        [calendarCollectionView, calendarMonthLabel, nextButton, previousButton].forEach {
            self.addSubview($0)
        }
        
        
        
        calendarMonthLabel.snp.makeConstraints {
            $0.width.equalTo(30)
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
            $0.width.equalTo(previousButton)
            $0.height.equalTo(previousButton)
            $0.left.equalTo(calendarMonthLabel.snp.right).offset(20)
            $0.centerY.equalTo(previousButton)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarMonthLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    private func setNeedsMonthDay() {}
    
    
    // MARK: 예약된 수업 캘린더 레이아웃 구성 함수
    private func createCalendarLayout() -> NSCollectionLayoutSection {
        
        let calendarItemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(calendarCollectionView.frame.size.width),
            heightDimension: .absolute(40)
        )
        
        
        let calendarLayoutItem = NSCollectionLayoutItem(
            layoutSize: calendarItemSize
        )
        
        calendarLayoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
        
        
        let calendarHorizontalLayoutSize = NSCollectionLayoutSize(widthDimension: .estimated(calendarCollectionView.frame.size.width),
                                                             heightDimension: .estimated(calendarCollectionView.frame.size.height))
        
        let calendarLayoutHorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: calendarHorizontalLayoutSize,
            subitem: calendarLayoutItem,
            count: 7
        )
        
        
        let calendarVerticalLayoutSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(calendarCollectionView.frame.size.width),
            heightDimension: .fractionalHeight(0.5)
        )
        
        let calendarVerticalLayoutGroup: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: calendarVerticalLayoutSize,
            subitem: calendarLayoutHorizontalGroup,
            count: 5
        )
        
        
        let calendarSectionHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(UIScreen.main.bounds.size.width),
            heightDimension: .absolute(40)
        )
        
        
        let calendarLayoutSection = NSCollectionLayoutSection(group: calendarVerticalLayoutGroup)
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


extension HPCalendarView: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        reactor.pulse(\.$section)
            .asDriver(onErrorJustReturn: [])
            .debug("test calendar Section")
            .drive(calendarCollectionView.rx.items(dataSource: self.calendarDataSource))
            .disposed(by: disposeBag)
    }
}



