//
//  CouponListView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/05.
//

import Foundation
import UIKit
import SnapKit

public final class CouponListView: UIView {
    private lazy var collectionView = UICollectionView(frame: .infinite, collectionViewLayout: createLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
    }

    /// coupons 값만 바꾸면 collection view도 자동으로 reload
    public var coupons: [DummyCoupon] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var index: Int {
        get {
            Int(round(Double(collectionView.contentOffset.x / (270 + 16))))
        }
        
        set {
            collectionView.contentOffset.x = CGFloat(newValue * 286)
            print(collectionView.contentOffset.x)
        }
    }
        
    public init(coupons: [DummyCoupon]) {
        self.coupons = coupons
        super.init(frame: .zero)
        collectionView.register(CouponCell.self, forCellWithReuseIdentifier: CouponCell.identifier)
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CouponListView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coupons.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let couponCell = collectionView.dequeueReusableCell(withReuseIdentifier: CouponCell.identifier, for: indexPath) as! CouponCell
        // TODO: 데이터 반영하기
        couponCell.studioName = "발란스 스튜디오"
        couponCell.couponName = "6:1 그룹레슨 10회 이용권"
        couponCell.count = 4
        couponCell.maxCount = 10
        couponCell.duration = 60
        return couponCell
    }
}

extension CouponListView {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(270), heightDimension: .absolute(146)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 16
            return section
        }
    }
}
