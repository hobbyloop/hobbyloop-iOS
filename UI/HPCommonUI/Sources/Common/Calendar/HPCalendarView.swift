//
//  HPCalendarView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/07/27.
//

import UIKit

import HPFoundation
import RxDataSources
import ReactorKit
import Then
import SnapKit


public final class HPCalendarView: UIView {
    
    public var color: UIColor = .white {
        //TODO: BackgroundColor Setting 부분 수정
        didSet {
            self.calendarCollectionView.backgroundColor = color
        }
    }
    
    
    public var isStyle: CalendarStyle  {
        didSet {
            if self.isStyle == .default {
                self.calendarCollectionView.collectionViewLayout = calendarCollectionViewLayout
                
            } else {
                self.calendarCollectionView.collectionViewLayout = bubbleCollectionViewLayout
            }
        }
    }
    

    // MARK: Property
    
    public var disposeBag: DisposeBag = DisposeBag()
    public typealias Reactor = HPCalendarViewReactor

    public weak var calendarContentView: HPCalendarContentView? {
        didSet {
            self.configure()
        }
    }
    
    
    private lazy var calendarDataSource: RxCollectionViewSectionedReloadDataSource<CalendarSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case let .calendarItem(cellReactor):
            guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarDayCell", for: indexPath) as? HPCalendarDayCell else { return UICollectionViewCell() }
            calendarCell.reactor = cellReactor
            
            return calendarCell
        case let .bubbleItem(cellReactor):
            guard let bubbleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarBubbleDayCell", for: indexPath) as? HPCalendarBubbleDayCell else { return UICollectionViewCell() }
            bubbleCell.reactor = cellReactor
            return bubbleCell
        }
    }

    
    private lazy var calendarCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
            
        return self.createCalendarLayout()
    }
    
    private lazy var bubbleCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        
        return self.createBubbleCalendarLayout()
    }
    
    
    
    private lazy var calendarCollectionView: UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: isStyle == .default ? calendarCollectionViewLayout : bubbleCollectionViewLayout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(HPCalendarDayCell.self, forCellWithReuseIdentifier: "HPCalendarDayCell")
        $0.register(HPCalendarBubbleDayCell.self, forCellWithReuseIdentifier: "HPCalendarBubbleDayCell")
        $0.register(HPCalendarWeekReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HPCalendarWeekReusableView")
    }
    
    public init(
        reactor: HPCalendarViewReactor,
        calendarContentView: HPCalendarContentView? = nil,
        isStyle: CalendarStyle
    ) {
        self.isStyle = isStyle
        super.init(frame: .zero)
        self.reactor = reactor
        self.calendarContentView = calendarContentView
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
       
        if let calendarContentView = self.calendarContentView {
            [calendarContentView, calendarCollectionView].forEach {
                self.addSubview($0)
            }
            
            calendarContentView.snp.makeConstraints {
                $0.left.right.top.equalToSuperview()
                $0.height.equalTo(40)
            }
            
            calendarCollectionView.snp.remakeConstraints {
                $0.top.equalTo(calendarContentView.snp.bottom)
                $0.left.right.bottom.equalToSuperview()
            }

        } else {
            self.addSubview(calendarCollectionView)


            calendarCollectionView.snp.remakeConstraints {
                $0.top.left.right.bottom.equalToSuperview()
            }
        }
        
        
        guard let contentView = self.calendarContentView,
              let reactor = self.reactor else { return }
        
        contentView
            .nextButton.rx.tap.debug("Tap Next Button Action")
            .map { Reactor.Action.didTapNextDateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
        contentView
            .previousButton.rx.tap
            .map { Reactor.Action.didTapPreviousDateButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
            
        reactor.state
            .map { "\($0.month)월" }
            .bind(to: contentView.calendarMonthLabel.rx.text)
            .disposed(by: disposeBag)
        
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
    
    
    private func createBubbleCalendarLayout() -> NSCollectionLayoutSection {
        let bubbleCalendarItemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(54),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let bubbleCalendarGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(calendarCollectionView.frame.size.height)
        )
        
        let bubbleCalendarLayoutItem = NSCollectionLayoutItem(
            layoutSize: bubbleCalendarItemSize
        )
        
        bubbleCalendarLayoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 7, bottom: 20, trailing: 7)
        
        let bubbleCalendarGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: bubbleCalendarGroupSize,
            subitem: bubbleCalendarLayoutItem,
            count: 6
        )
        
        let bubbleCalendarSection = NSCollectionLayoutSection(group: bubbleCalendarGroup)
        bubbleCalendarSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        bubbleCalendarSection.orthogonalScrollingBehavior = .continuous
        
        
        return bubbleCalendarSection
    }

}


extension HPCalendarView: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        

        Observable
            .just(())
            .map { Reactor.Action.changeCalendarStyle(self.isStyle)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.style }
            .take(1)
            .distinctUntilChanged()
            .bind(onNext: { style in
                if style == .default {
                    self.calendarDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                        guard let weekDayReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HPCalendarWeekReusableView", for: indexPath) as? HPCalendarWeekReusableView else { return UICollectionReusableView() }
                        return weekDayReusableView
                    }
                } else {
                    self.calendarDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                        return UICollectionReusableView()
                    }
                }
            }).disposed(by: disposeBag)
        
        
        reactor.pulse(\.$section)
            .debug("test calendar Section")
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: calendarCollectionView.rx.items(dataSource: self.calendarDataSource))
            .disposed(by: disposeBag)
        
        
        NotificationCenter.default
            .rx.notification(.NSCalendarDayChanged)
            .subscribe(onNext: { [weak self] _ in
                print("notification changed date")
                guard let style = self?.reactor?.currentState.style else { return }
                self?.reactor?.action.onNext(.changeCalendarStyle(style))
            }).disposed(by: disposeBag)

        reactor.state
            .map { $0.nowDay }
            .debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .observe(on: MainScheduler.asyncInstance)
            .bind { index in
                self.calendarCollectionView.scrollToItem(at: IndexPath(row: index - 1, section: 0), at: .centeredHorizontally, animated: true)
            }.disposed(by: disposeBag)
                
    }
}
