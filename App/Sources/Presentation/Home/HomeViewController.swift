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
            
            return explanationCell
        }
        
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let scheduleReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ScheduleReusableView", for: indexPath) as? ScheduleReusableView else { return UICollectionReusableView() }
            
            return scheduleReusableView
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
        }
        
    }
    
    
    private lazy var homeCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.homeCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.register(ScheduleCell.self, forCellWithReuseIdentifier: "ScheduleCell")
        $0.register(ExplanationCell.self, forCellWithReuseIdentifier: "ExplanationCell")
        $0.register(ScheduleReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ScheduleReusableView")
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
            heightDimension: .absolute(256)
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
