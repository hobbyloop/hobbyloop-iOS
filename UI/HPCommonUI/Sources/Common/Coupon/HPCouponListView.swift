//
//  HPCouponListView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/11.
//


import UIKit
import SnapKit
import Then
import RxDataSources
import ReactorKit



public protocol CouponImplementable {
    func createLoopPassLayout() -> NSCollectionLayoutSection
    func createTicketLayout() -> NSCollectionLayoutSection
}

public final class HPCouponListView: BaseView<HPCouponViewReactor>, CouponImplementable {
    
    private lazy var couponDataSource: RxCollectionViewSectionedReloadDataSource<HPCouponSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        switch sectionItem {
        case .loopPassItem:
            return UICollectionViewCell()
        case let .ticketItem(cellReactor):
            guard let couponCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCouponCell", for: indexPath) as? HPCouponCell else { return UICollectionViewCell() }
            couponCell.reactor = cellReactor
            return couponCell
        }
    }
    
    private lazy var couponCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout {
        section, _ in
        let dataSource = self.couponDataSource[section]
        
        switch dataSource {
        case .loopPass:
            return self.createLoopPassLayout()
        case .ticket:
            return self.createTicketLayout()
        }
    }
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: couponCollectionViewLayout).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(HPCouponCell.self, forCellWithReuseIdentifier: "HPCouponCell")
        $0.backgroundColor = HPCommonUIAsset.white.color
    }
    
    public override init(reactor: HPCouponViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    public override func bind(reactor: Reactor) {
        Observable.just(())
            .map { Reactor.Action.loadView}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$couponSection)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(dataSource: self.couponDataSource))
            .disposed(by: disposeBag)
        
        
        
        
    }
    
    
    
}

extension HPCouponListView {
    
    public func createTicketLayout() -> NSCollectionLayoutSection {
        let ticketLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(179)
        )
        
        let ticketLayoutItem = NSCollectionLayoutItem(
            layoutSize: ticketLayoutSize
        )
        
        ticketLayoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        
        let ticketLayoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(179)
        )
        
        let ticketLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketLayoutGroupSize,
            subitems: [ticketLayoutItem]
        )
        
        let ticketLayoutSection = NSCollectionLayoutSection(
            group: ticketLayoutGroup
        )
        
        ticketLayoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return ticketLayoutSection
    }
    
    public func createLoopPassLayout() -> NSCollectionLayoutSection {
        
        let loopPassLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.frame.size.width),
            heightDimension: .estimated(179)
        )
        
        let loopPassLayoutItem = NSCollectionLayoutItem(
            layoutSize: loopPassLayoutSize
        )
        
        let loopPassLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: loopPassLayoutSize,
            subitem: loopPassLayoutItem,
            count: 1
        )
        
        let loopPassLayoutSection = NSCollectionLayoutSection(
            group: loopPassLayoutGroup
        )
        
        return loopPassLayoutSection
        
    }
    
}
