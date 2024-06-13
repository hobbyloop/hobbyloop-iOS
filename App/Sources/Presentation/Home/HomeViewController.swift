//
//  HomeViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPFoundation
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources


private protocol HomeLayoutCreatable: AnyObject {
    
    func createUserInfoProvideLayout() -> NSCollectionLayoutSection
    func createSelectCategoryLayout(_ numberOfItems: CGFloat) -> NSCollectionLayoutSection
    func createCalendarLayout() -> NSCollectionLayoutSection
    func createAdvertisementClassLayout() -> NSCollectionLayoutSection
    func createExplanationClassLayout() -> NSCollectionLayoutSection
    func createExerciseClassLayout() -> NSCollectionLayoutSection
    func createWeekHotTicketLayout(_ numberOfItems: CGFloat) -> NSCollectionLayoutSection
    
}


public final class HomeViewController: BaseViewController<HomeViewReactor> {
    
    // MARK: Property
    
    
    public var numberOfItems: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.homeCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    private lazy var homeDataSource: RxCollectionViewSectionedReloadDataSource<HomeSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .userInfoClassItem:
            guard let userInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInfoProvideCell", for: indexPath) as? UserInfoProvideCell else { return UICollectionViewCell() }
            userInfoCell.delegate = self
            return userInfoCell
            
        case .selectCategoryClassItem:
            guard let selectCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            return selectCategoryCell
            
        case .advertisementClassItem:
            guard let scheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisementCell", for: indexPath) as? AdvertisementCell else { return UICollectionViewCell() }
            
            return scheduleCell
            
        case .explanationClassItem:
            guard let explanationCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExplanationCell", for: indexPath) as? ExplanationCell else {
                return UICollectionViewCell() }
            
            #warning("수정 대기")
            explanationCell.delegate = self
            return explanationCell
            
        case .weekHotTicketClassItem:
            guard let weekHotTicketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekHotTicketCell", for: indexPath) as? WeekHotTicketCell else { return UICollectionViewCell() }
            
            return weekHotTicketCell
            
        case .exerciseClassItem:
            guard let exerciseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }
            return exerciseCell
            
        case .calendarClassItem:
            guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
            
            return calendarCell

        }
        
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        let dataSource = dataSource[indexPath]
        
        switch dataSource {
        case .selectCategoryClassItem:
            guard let selectCategoryReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EventResusableView", for: indexPath) as? EventResusableView else { return UICollectionReusableView () }
            return selectCategoryReusableView
            
        case .exerciseClassItem:
            guard let exerciseReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExerciseReusableView", for: indexPath) as? ExerciseReusableView else { return UICollectionReusableView() }
            return exerciseReusableView
            
        case .weekHotTicketClassItem:
            guard let weekHotTicketReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekHotTicketReusableView", for: indexPath) as? WeekHotTicketReusableView else { return UICollectionReusableView () }
            return weekHotTicketReusableView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    private lazy var homeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] (section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        guard let self = self else { return nil }
        let section = self.homeDataSource.sectionModels[section]
        
        switch section {
        case .userInfoClass:
            return self.createUserInfoProvideLayout()
        case .calendarClass:
            return self.numberOfItems ?? 0 >= 36 ? self.adjustCalendarLayout() : self.createCalendarLayout()
            
        case .selectCategoryClass:
            guard let count = CGFloat(exactly: section.items.count) else { return nil }
            return self.createSelectCategoryLayout(count)
            
        case .advertisementClass:
            return self.createAdvertisementClassLayout()
            
        case .explanationClass:
            return self.createExplanationClassLayout()
            
        case .exerciseClass:
            return self.createExerciseClassLayout()
            
        case .weekHotTicketClass:
            guard let count = CGFloat(exactly: section.items.count) else { return nil }
            return self.createWeekHotTicketLayout(count)
        }
        
    }
    
    
    private lazy var homeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.homeCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.register(UserInfoProvideCell.self, forCellWithReuseIdentifier: "UserInfoProvideCell")
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        $0.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        $0.register(AdvertisementCell.self, forCellWithReuseIdentifier: "AdvertisementCell")
        $0.register(ExplanationCell.self, forCellWithReuseIdentifier: "ExplanationCell")
        $0.register(ExerciseCell.self, forCellWithReuseIdentifier: "ExerciseCell")
        $0.register(WeekHotTicketCell.self, forCellWithReuseIdentifier: "WeekHotTicketCell")
        $0.collectionViewLayout.register(SystemBackgroundDecorationView.self, forDecorationViewOfKind: "SystemBackgroundDecorationView")
        $0.collectionViewLayout.register(WhiteBackgroundDecorationView.self, forDecorationViewOfKind: "WhiteBackgroundDecorationView")
        $0.register(ExerciseReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExerciseReusableView")
        $0.register(WeekHotTicketReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WeekHotTicketReusableView")
        $0.register(EventResusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EventResusableView")
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        
        
    }
    
    override init(reactor: HomeViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function)
    }
    
    
    
    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: Configure
    private func configure() {
        self.view.addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public override func bind(reactor: HomeViewReactor) {
        
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$section)
            .asDriver(onErrorJustReturn: [])
            .drive(homeCollectionView.rx.items(dataSource: self.homeDataSource))
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(.reloadCalendar)
            .withUnretained(self)
            .subscribe(onNext: { owner, noti in
                guard let count = noti.object as? Int else { return }
                owner.numberOfItems = count
            }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - Colletion View Layout
extension HomeViewController: HomeLayoutCreatable {
    
    fileprivate func createUserInfoProvideLayout() -> NSCollectionLayoutSection {
        let userInfoProvideLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(90 + 140 /*티켓 높이까지 지정*/)
        )
        
        let userInfoProvideItem = NSCollectionLayoutItem(layoutSize: userInfoProvideLayoutSize)
        
        let userInfoProvideGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: userInfoProvideLayoutSize,
            subitem: userInfoProvideItem,
            count: 1
        )
        
        let userInfoProvideSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(SystemBackgroundDecorationView.self)")
        
        let userInfoProvideSection = NSCollectionLayoutSection(group: userInfoProvideGroup)
        userInfoProvideSection.decorationItems = [userInfoProvideSectionBackground]
        
        userInfoProvideSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)
        
        return userInfoProvideSection
    }
    
    
    fileprivate func createSelectCategoryLayout(_ numberOfItems: CGFloat) -> NSCollectionLayoutSection {
        
        let categoryItemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(56),
            heightDimension: .absolute(80)
        )
        
        let categoryLayoutItem = NSCollectionLayoutItem(layoutSize: categoryItemLayoutSize)
        
        // Calculate the width based on the number of items and inter-item spacing
        let interItemSpacing: CGFloat = 24
        let totalInterItemSpacing = interItemSpacing * (numberOfItems - 1)
        let totalItemWidth = categoryItemLayoutSize.widthDimension.dimension * numberOfItems
        let categoryGroupWidth = totalItemWidth + totalInterItemSpacing
        
        let categoryGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(categoryGroupWidth),
            heightDimension: .absolute(80)
        )
        
        // 설정한 간격을 포함하여 그룹 만들기
        let categoryGroupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: categoryGroupLayoutSize,
            subitems: [categoryLayoutItem]
        )
        
        // 아이템 간의 간격을 24로 설정
        categoryGroupLayout.interItemSpacing = .fixed(24)
        
        let categorySection = NSCollectionLayoutSection(group: categoryGroupLayout)
        
        categorySection.interGroupSpacing = 24
        
        categorySection.contentInsets = .init(top: 32, leading: 16, bottom: 24, trailing: 16)
        categorySection.orthogonalScrollingBehavior = .continuous
        
        let categorySectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        categorySectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        categorySection.decorationItems = [categorySectionBackground]
        
        let categoryHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width - 32),
            heightDimension: .absolute(98 + 24)
        )
        
        let categoryHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: categoryHeaderLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        categorySection.boundarySupplementaryItems = [categoryHeader]
        
        
        return categorySection
        
    }
    
    fileprivate func adjustCalendarLayout() -> NSCollectionLayoutSection {
        let dynamicCalendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width - 32),
            heightDimension: .estimated(310)
        )
        let dynamicCalendarGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(310)
        )
        
        let calendarLayoutItem = NSCollectionLayoutItem(
            layoutSize: dynamicCalendarLayoutSize
        )
        
        let dynamicCalendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: dynamicCalendarGroupSize,
            subitem: calendarLayoutItem,
            count: 1
        )
        
        let dynamicCalendarSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(SystemBackgroundDecorationView.self)")
        
        
        let dynamicCalendarSection = NSCollectionLayoutSection(group: dynamicCalendarLayoutGroup)
        
        dynamicCalendarSection.decorationItems = [dynamicCalendarSectionBackground]
                
        
        return dynamicCalendarSection
    }
    
    fileprivate func createCalendarLayout() -> NSCollectionLayoutSection {
        let calendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width - 32),
            heightDimension: .estimated(280)
        )
        let calendarGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(280)
        )
        
        let calendarLayoutItem = NSCollectionLayoutItem(
            layoutSize: calendarLayoutSize
        )
        
        let calendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: calendarGroupSize,
            subitem: calendarLayoutItem,
            count: 1
        )
        
        let calendarSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(SystemBackgroundDecorationView.self)")
        
        
        let calendarSection = NSCollectionLayoutSection(group: calendarLayoutGroup)
        
        calendarSection.decorationItems = [calendarSectionBackground]
                
        
        return calendarSection
    }
    
    fileprivate func createAdvertisementClassLayout() -> NSCollectionLayoutSection {
        
        let scheduleClassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(82)
        )
        
        let scheduleClassItem = NSCollectionLayoutItem(layoutSize: scheduleClassLayoutSize)
        
        let scheduleClassGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: scheduleClassLayoutSize,
            subitems: [scheduleClassItem]
        )
        
        let scheduleClassSection = NSCollectionLayoutSection(
            group: scheduleClassGroup
        )

        return scheduleClassSection
        
    }
    
    fileprivate func createExplanationClassLayout() -> NSCollectionLayoutSection {
        
        let explanationClassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(386)
        )
        
        let explanationClassItem = NSCollectionLayoutItem(layoutSize: explanationClassLayoutSize)
        
        let explanationClassGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: explanationClassLayoutSize,
            subitems: [explanationClassItem]
        )
        
        let explanationClassSection = NSCollectionLayoutSection(group: explanationClassGroup)
        
        
        
        
        return explanationClassSection
    }
    
    fileprivate func createExerciseClassLayout() -> NSCollectionLayoutSection {
        let exerciseClassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(327),
            heightDimension: .absolute(200)
        )
        
        let exerciseClassItem = NSCollectionLayoutItem(layoutSize: exerciseClassLayoutSize)
    
        
        let exerciseGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(327),
            heightDimension: .absolute(310)
        )
        
        let exerciseClassGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: exerciseGroupLayoutSize,
            subitems: [exerciseClassItem]
        )
        
        
        let exerciseSectionHeaderLayoutSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(65)
        )
        
        let exerciseSection = NSCollectionLayoutSection(
            group: exerciseClassGroup
        )
        
        exerciseSection.interGroupSpacing = 11
        exerciseSection.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let exerciseSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        
        exerciseSectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0)
        exerciseSection.decorationItems = [exerciseSectionBackground]
        
        exerciseSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        exerciseSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: exerciseSectionHeaderLayoutSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        
        return exerciseSection
    }
    
    fileprivate func createWeekHotTicketLayout(_ numberOfItems: CGFloat) -> NSCollectionLayoutSection {
        
        let weekHotTicketItemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(173),
            heightDimension: .absolute(267)
        )
        
        let weekHotTicketLayoutItem = NSCollectionLayoutItem(layoutSize: weekHotTicketItemLayoutSize)
        
        // Calculate the width based on the number of items and inter-item spacing
        let interItemSpacing: CGFloat = 12
        let totalInterItemSpacing = interItemSpacing * (numberOfItems - 1)
        let totalItemWidth = weekHotTicketItemLayoutSize.widthDimension.dimension * numberOfItems
        let categoryGroupWidth = totalItemWidth + totalInterItemSpacing
        
        let weekHotTicketGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(categoryGroupWidth),
            heightDimension: .absolute(283)
        )
        
        let weekHotTicketGroupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: weekHotTicketGroupLayoutSize,
            subitems: [weekHotTicketLayoutItem]
        )
        
        weekHotTicketGroupLayout.interItemSpacing = .fixed(12)
        
        let weekHotTicketSection = NSCollectionLayoutSection(
            group: weekHotTicketGroupLayout
        )
        
        weekHotTicketSection.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        
        let weekHotTicketSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        weekHotTicketSectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0)
        weekHotTicketSection.orthogonalScrollingBehavior = .continuous
        
        weekHotTicketSection.decorationItems = [weekHotTicketSectionBackground]
        
        let weekHotTicketHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width - 32),
            heightDimension: .absolute(58)
        )
        
        let weekHotTicketHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: weekHotTicketHeaderLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        weekHotTicketSection.boundarySupplementaryItems = [weekHotTicketHeader]
        
        return weekHotTicketSection
    }
    
}

// MARK: - Delegate
extension HomeViewController: ExplanationDelegate {
    
    public func showOnboardingView() {
        let onboardingController = OnboardingDIContainer().makeViewController()
        onboardingController.modalPresentationStyle = .fullScreen
        self.present(onboardingController, animated: true)
    }
    
}
