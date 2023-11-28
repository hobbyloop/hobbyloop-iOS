//
//  OnboardingViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import UIKit

import HPCommonUI
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources


final class OnboardingViewController: BaseViewController<OnboardingViewReactor> {
    
    private lazy var onboardingDataSource: RxCollectionViewSectionedReloadDataSource<OnboardingSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case let .OnboardingItems(cellReactor):
            guard let onboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
            onboardingCell.delegate = self
            onboardingCell.reactor = cellReactor
            return onboardingCell
        }
    }
    
    
    private lazy var onboardingCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] section, _ -> NSCollectionLayoutSection? in
        let section = self?.onboardingDataSource.sectionModels[section]
        
        switch section {
        case .Onboarding:
            return self?.createOnboardingLayout()
        default:
            return nil
        }
    })
    
    
    
    private lazy var onboardingCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: onboardingCollectionViewLayout).then {
        $0.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        $0.contentInset = .zero
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        
    }
    
    
    override init(reactor: OnboardingViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        self.view.backgroundColor = .white
        self.view.addSubview(onboardingCollectionView)
        
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    private func createOnboardingLayout() -> NSCollectionLayoutSection {
        
        let onboardingLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(self.view.frame.size.height)
        )
        
        let onboardingItem = NSCollectionLayoutItem(layoutSize: onboardingLayoutSize)
        
        let onboardingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: onboardingLayoutSize,
            subitems: [onboardingItem]
        )
        
        let onboardingSection = NSCollectionLayoutSection(group: onboardingGroup)
        onboardingSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return onboardingSection
    }
    
    
    override func bind(reactor: Reactor) {
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.onboardingCollectionView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$section)
            .asDriver(onErrorJustReturn: [])
            .drive(onboardingCollectionView.rx.items(dataSource: self.onboardingDataSource))
            .disposed(by: disposeBag)
        
        
    }
    
}



extension OnboardingViewController: UICollectionViewDelegateFlowLayout {}


extension OnboardingViewController: OnboardingDelegate {
    func onboardingViewDismiss() {
        self.dismiss(animated: true)
    }
}

