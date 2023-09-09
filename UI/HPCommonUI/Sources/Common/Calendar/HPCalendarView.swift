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


public enum CalendarStatus {
    case single
    case multiple
}

public final class HPCalendarView: UIView {
    
    public var isStatus: CalendarStatus = .single {
        didSet {
            //TODO: status 에 따라 ColletionView Layout UI 변경
            self.calendarCollectionView.setCollectionViewLayout(UICollectionViewLayout(), animated: true)
        }
    }
    

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
        }
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        
        guard let weekDayReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HPCalendarWeekReusableView", for: indexPath) as? HPCalendarWeekReusableView else { return UICollectionReusableView() }
        
        return weekDayReusableView
        
    }

    
    private lazy var calendarCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
    
        return self.createCalendarLayout()
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
        self.calendarCollectionView.backgroundColor = HPCommonUIAsset.systemBackground.color
        
        [calendarCollectionView, calendarMonthLabel, nextButton, previousButton].forEach {
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
            $0.width.equalTo(previousButton)
            $0.height.equalTo(previousButton)
            $0.left.equalTo(calendarMonthLabel.snp.right).offset(20)
            $0.centerY.equalTo(previousButton)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarMonthLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    // MARK: 예약된 수업 캘린더 레이아웃 구성 함수
    private func createCalendarLayout() -> NSCollectionLayoutSection {
        
        let calendarItemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(calendarCollectionView.frame.size.width),
            heightDimension: .absolute(30)
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
            heightDimension: .estimated(180)
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

}


extension HPCalendarView: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        

        Observable
            .just(())
            .map { Reactor.Action.loadView}
            .debug("Load View HP Calendar View")
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$section)
            .asDriver(onErrorJustReturn: [])
            .debug("test calendar Section")
            .drive(calendarCollectionView.rx.items(dataSource: self.calendarDataSource))
            .disposed(by: disposeBag)

        nextButton
            .rx.tap
            .map { Reactor.Action.didTapNextDateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        previousButton
            .rx.tap
            .map { Reactor.Action.didTapPreviousDateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { "\($0.month)월" }
            .asDriver(onErrorJustReturn: "")
            .drive(calendarMonthLabel.rx.text)
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(.NSCalendarDayChanged)
            .subscribe(onNext: { [weak self] _ in
                print("notification changed date")
                self?.reactor?.action.onNext(.loadView)
            }).disposed(by: disposeBag)
        
        
        calendarCollectionView
            .rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                
            }).disposed(by: disposeBag)
        
    }
}



