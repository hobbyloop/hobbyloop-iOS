//
//  HomeViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPExtensions
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources


private protocol HomeLayoutCreatable: AnyObject {
    
    func createUserInfoProvideLayout() -> NSCollectionLayoutSection
    func createTicketLayout() -> NSCollectionLayoutSection
    func createCalendarLayout() -> NSCollectionLayoutSection
    func createSchedulClassLayout() -> NSCollectionLayoutSection
    func createExplanationClassLayout() -> NSCollectionLayoutSection
    func createExerciseClassLayout() -> NSCollectionLayoutSection
    func createBenefitsLayout() -> NSCollectionLayoutSection
    
}


public final class HomeViewController: BaseViewController<HomeViewReactor> {
    
    // MARK: Property
    
    private lazy var homeDataSource: RxCollectionViewSectionedReloadDataSource<HomeSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .userInfoClassItem:
            guard let userInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInfoProvideCell", for: indexPath) as? UserInfoProvideCell else { return UICollectionViewCell() }
            return userInfoCell
            
        case .calendarClassItem:
            guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
            
            return calendarCell
            
        case .ticketClassItem:
            guard let ticketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCell", for: indexPath) as? TicketCell else { return UICollectionViewCell() }
            
            return ticketCell
            
            
        case .schedulClassItem:
            guard let scheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
            
            return scheduleCell
            
        case .explanationClassItem:
            guard let explanationCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExplanationCell", for: indexPath) as? ExplanationCell else {
                return UICollectionViewCell() }
            
            explanationCell.delegate = self
            return explanationCell
        case .exerciseClassItem:
            guard let exerciseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }
            return exerciseCell
        case .benefitsClassItem:
            guard let benefitsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitsCell", for: indexPath) as? BenefitsCell else { return UICollectionViewCell() }
            
            
            return benefitsCell
        }
        
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        let dataSource = dataSource[indexPath]
        
        switch dataSource {
        case .exerciseClassItem:
            guard let exerciseReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExerciseReusableView", for: indexPath) as? ExerciseReusableView else { return UICollectionReusableView() }
            return exerciseReusableView
            
        case .benefitsClassItem:
            guard let benefitsReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BenefitsReusableView", for: indexPath) as? BenefitsReusableView else { return UICollectionReusableView () }
            return benefitsReusableView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    private lazy var homeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] section, env in
        
        let section = self?.homeDataSource.sectionModels[section]
        
        switch section {
        case .userInfoClass:
            return self?.createUserInfoProvideLayout()
        case .calendarClass:
            return self?.createCalendarLayout()
            
        case .ticketClass:
            return self?.createTicketLayout()
        case .schedulClass:
            return self?.createSchedulClassLayout()
            
        case .explanationClass:
            return self?.createExplanationClassLayout()
            
        case .exerciseClass:
            return self?.createExerciseClassLayout()
            
        case .benefitsClass:
            return self?.createBenefitsLayout()
        case .none:
            //TODO: Empty Layout 추가 예정
            return nil
        }
        
    }
    
    
    private lazy var homeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.homeCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.register(UserInfoProvideCell.self, forCellWithReuseIdentifier: "UserInfoProvideCell")
        $0.register(TicketCell.self, forCellWithReuseIdentifier: "TicketCell")
        $0.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        $0.register(ScheduleCell.self, forCellWithReuseIdentifier: "ScheduleCell")
        $0.register(ExplanationCell.self, forCellWithReuseIdentifier: "ExplanationCell")
        $0.register(ExerciseCell.self, forCellWithReuseIdentifier: "ExerciseCell")
        $0.register(BenefitsCell.self, forCellWithReuseIdentifier: "BenefitsCell")
        $0.collectionViewLayout.register(SystemBackgroundDecorationView.self, forDecorationViewOfKind: "SystemBackgroundDecorationView")
        $0.collectionViewLayout.register(WhiteBackgroundDecorationView.self, forDecorationViewOfKind: "WhiteBackgroundDecorationView")
        $0.register(ExerciseReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExerciseReusableView")
        $0.register(BenefitsReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BenefitsReusableView")
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
        
    }
    
}



extension HomeViewController: ExplanationDelegate {
    
    public func showOnboardingView() {
        let onboardingController = OnboardingDIContainer().makeViewController()
        onboardingController.modalPresentationStyle = .fullScreen
        self.present(onboardingController, animated: true)
    }
    
}



extension HomeViewController: HomeLayoutCreatable {
    
    fileprivate func createUserInfoProvideLayout() -> NSCollectionLayoutSection {
        let userInfoProvideLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(90)
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
        
        userInfoProvideSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return userInfoProvideSection
    }
    
    
    fileprivate func createTicketLayout() -> NSCollectionLayoutSection {
        
        let ticketLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(140)
        )
        
        let ticketLayoutItem = NSCollectionLayoutItem(layoutSize: ticketLayoutSize)
        
        let ticketLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketLayoutSize,
            subitems: [ticketLayoutItem]
        )
        
        let ticketSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(SystemBackgroundDecorationView.self)")
        
        let ticketSection = NSCollectionLayoutSection(group: ticketLayoutGroup)
        ticketSection.decorationItems = [ticketSectionBackground]
        ticketSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        
        return ticketSection
        
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
                
        calendarSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return calendarSection
    }
    
    fileprivate func createSchedulClassLayout() -> NSCollectionLayoutSection {
        
        let scheduleClassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(160)
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
    
    
    
    //MARK: 오늘의 운동 섹션 레이아웃 구성 함수
    /// - Return : NSCollectionLayoutSize
    fileprivate func createExerciseClassLayout() -> NSCollectionLayoutSection {
        let exerciseClassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(339)
        )
        
        let exerciseClassItem = NSCollectionLayoutItem(layoutSize: exerciseClassLayoutSize)
        
        exerciseClassItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let exerciseGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(339)
        )
        
        let exerciseClassGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: exerciseGroupLayoutSize,
            subitems: [exerciseClassItem]
        )
        
        
        let exerciseSectionHeaderLayoutSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(50)
        )
        
        let exerciseSection = NSCollectionLayoutSection(
            group: exerciseClassGroup
        )
        
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
    
    //MARK: 오늘의 혜택 섹션 레이아웃 구성 함수
    /// - Return : NSCollectionLayoutSize
    fileprivate func createBenefitsLayout() -> NSCollectionLayoutSection {
        
        let benefitsItemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        
        let benefitsLayoutItem = NSCollectionLayoutItem(layoutSize: benefitsItemLayoutSize)
        
        benefitsLayoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 12
        )
        
        let benefitsGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.92),
            heightDimension: .absolute(200)
        )
        
        let benefitsGroupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: benefitsGroupLayoutSize,
            subitems: [benefitsLayoutItem]
        )
        
        let benefitsSection = NSCollectionLayoutSection(
            group: benefitsGroupLayout
        )
        
        let benefitsSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        benefitsSectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0)
        benefitsSection
            .orthogonalScrollingBehavior = .groupPagingCentered
        
        benefitsSection.decorationItems = [benefitsSectionBackground]
        
        let benefitsHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(50)
        )
        
        let benefitsHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: benefitsHeaderLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        benefitsSection.boundarySupplementaryItems = [benefitsHeader]
        
        return benefitsSection
    }
}
