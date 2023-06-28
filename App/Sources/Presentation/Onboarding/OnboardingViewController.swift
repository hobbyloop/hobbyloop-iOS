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
    
    private var onboardingDataSource: RxCollectionViewSectionedReloadDataSource<OnboardingSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case let .OnboardingItems(cellReactor):
            guard let onboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
            onboardingCell.reactor = cellReactor
            
            return onboardingCell
        }
    }

    private let onboardingCollectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = .zero
    }
    
    private lazy var onboardingCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: onboardingCollectionViewFlowLayout).then {
        $0.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        $0.showsHorizontalScrollIndicator = false
        
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
    
    
    override func bind(reactor: Reactor) {
        
        // TODO: UICollectionViewCompositionalLayout으로 구현 하도록 수정
        
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



extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
}



