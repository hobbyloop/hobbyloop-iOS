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
        default:
            return UICollectionViewCell()
        }
        
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        let dataSource = dataSource[indexPath]
        
        switch dataSource {
        case .schedulClassItem:
            guard let scheduleReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ScheduleReusableView", for: indexPath) as? ScheduleReusableView else { return UICollectionReusableView() }
            
            return scheduleReusableView
            
        case .exerciseClassItem:
            guard let exerciseReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExerciseReusableView", for: indexPath) as? ExerciseReusableView else { return UICollectionReusableView() }
            return exerciseReusableView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    private lazy var homeCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        
        let section = self.homeDataSource.sectionModels[section]
        
        switch section {
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
        $0.register(ScheduleCell.self, forCellWithReuseIdentifier: "ScheduleCell")
        $0.register(ExplanationCell.self, forCellWithReuseIdentifier: "ExplanationCell")
        $0.register(ExerciseCell.self, forCellWithReuseIdentifier: "ExerciseCell")
        $0.register(ScheduleReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ScheduleReusableView")
        $0.register(ExerciseReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ExerciseReusableView")
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
        
        /// ScheduleSection Header Layout Size
        let scheduleSectionHeaderLayoutSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(100)
        )
        
        scheduleClassSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: scheduleSectionHeaderLayoutSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        

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
        
        exerciseClassItem.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 0, trailing: 10)
        
        let exerciseClassGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(339)),
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
        
        return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.size.width), heightDimension: .absolute(100))))
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
