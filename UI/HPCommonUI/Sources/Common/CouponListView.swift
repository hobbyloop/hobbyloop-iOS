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
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var pageControl = HPPageControl().then {
        $0.numberOfPages = 3
        $0.currentPage = 0
    }
    
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
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
            $0.height.equalTo(179)
        }
        
        self.addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
            $0.centerX.equalTo(collectionView.snp.centerX)
        }
    }
    
    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.bounds.width - 58, height: 179)
        layout.minimumLineSpacing = 14.5
        layout.scrollDirection = .horizontal
        pageControl.backgroundStyle = .minimal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension CouponListView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let couponCell = collectionView.dequeueReusableCell(withReuseIdentifier: CouponCell.identifier, for: indexPath) as! CouponCell
        
        return couponCell
    }
}

extension CouponListView: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
        // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if CGFloat(currentIndex) > roundedIndex {
            currentIndex -= 1
            roundedIndex = CGFloat(currentIndex)
        } else if CGFloat(currentIndex) < roundedIndex {
            currentIndex += 1
            roundedIndex = CGFloat(currentIndex)
        }
        
        // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
