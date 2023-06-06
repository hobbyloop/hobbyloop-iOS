//
//  CouponListView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/05.
//

import UIKit
import SnapKit

public final class CouponListView: UIView {
    private lazy var collectionView = UICollectionView(frame: .infinite, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.dataSource = self
    }
    
    public override var bounds: CGRect {
        didSet {
            configureCollectionView()
        }
    }
        
    public init() {
        super.init(frame: .zero)
        collectionView.register(CouponCell.self, forCellWithReuseIdentifier: CouponCell.identifier)
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(179)
        }
    }
    
    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.bounds.width - 58, height: 179)
        layout.minimumLineSpacing = 14.5
        layout.scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension CouponListView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let couponCell = collectionView.dequeueReusableCell(withReuseIdentifier: CouponCell.identifier, for: indexPath) as! CouponCell
        
        return couponCell
    }
}
