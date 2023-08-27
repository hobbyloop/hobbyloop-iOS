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


final class HomeViewController: BaseViewController<HomeViewReactor> {
    
    // MARK: Property
    
    private lazy var homeDataSource: RxCollectionViewSectionedReloadDataSource<HomeSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .calendarClassItem:
            guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
            
            return calendarCell
            
            
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
        case .calendarClassItem:
            guard let scheduleReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ScheduleReusableView", for: indexPath) as? ScheduleReusableView else { return UICollectionReusableView() }
            
            return scheduleReusableView
            
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
    
    private lazy var homeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        
        let section = self.homeDataSource.sectionModels[section]
        
        switch section {
        case .calendarClass:
            return self.createCalendarLayout()
        case .schedulClass:
            return self.createSchedulClassLayout()
            
        case .explanationClass:
            return self.createExplanationClassLayout()
            
        case .exerciseClass:
            return self.createExerciseClassLayout()
            
        case .benefitsClass:
            return self.createBenefitsLayout()
        }
        
    }
    
    
    private lazy var homeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.homeCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        $0.register(ScheduleCell.self, forCellWithReuseIdentifier: "ScheduleCell")
        $0.register(ExplanationCell.self, forCellWithReuseIdentifier: "ExplanationCell")
        $0.register(ExerciseCell.self, forCellWithReuseIdentifier: "ExerciseCell")
        $0.register(BenefitsCell.self, forCellWithReuseIdentifier: "BenefitsCell")
        $0.register(ScheduleReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ScheduleReusableView")
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
    override func viewDidLoad() {
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
    
    private func createCalendarLayout() -> NSCollectionLayoutSection {
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
        
        
        let calendarSection = NSCollectionLayoutSection(group: calendarLayoutGroup)
        
        let calendarSectionHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(100)
        )
        
        calendarSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: calendarSectionHeaderLayoutSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        return calendarSection
    }
    
    
    private func createSchedulClassLayout() -> NSCollectionLayoutSection {
        
        
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
    
    private func createExplanationClassLayout() -> NSCollectionLayoutSection {
        
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
    private func createExerciseClassLayout() -> NSCollectionLayoutSection {
        
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
    private func createBenefitsLayout() -> NSCollectionLayoutSection {
        
        let benefitsItemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(230)
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
            heightDimension: .absolute(230)
        )
        
        let benefitsGroupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: benefitsGroupLayoutSize,
            subitems: [benefitsLayoutItem]
        )
        
        let benefitsSection = NSCollectionLayoutSection(
            group: benefitsGroupLayout
        )
        
        benefitsSection
            .orthogonalScrollingBehavior = .groupPagingCentered
        
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
    
    
    
    override func bind(reactor: HomeViewReactor) {
        
        
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
    
    func showOnboardingView() {
        let onboardingController = OnboardingDIContainer().makeViewController()
        onboardingController.modalPresentationStyle = .fullScreen
        self.present(onboardingController, animated: true)
    }
    
}
