//
//  HPCalendarWeekReusableView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/23.
//

import UIKit

import SnapKit
import Then

public final class HPCalendarWeekReusableView: UICollectionReusableView, UICollectionViewDelegate {

    
    private let weekEntity: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    private lazy var weekCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(HPCalendarWeekCell.self, forCellWithReuseIdentifier: "HPCalendarWeekCell")
        $0.delegate = self
        $0.dataSource = self
    }
    
    private let weekUnderLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.lineSeparator.color
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        weekCollectionView.backgroundColor = HPCommonUIAsset.systemBackground.color
        [weekCollectionView, weekUnderLineView].forEach {
            self.addSubview($0)
        }
        weekCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        weekUnderLineView.snp.makeConstraints {
            $0.top.equalTo(weekCollectionView.snp.bottom)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }
    }
    
}



extension HPCalendarWeekReusableView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weekEntity.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let weekCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarWeekCell", for: indexPath) as? HPCalendarWeekCell else { return UICollectionViewCell() }
        weekCell.reactor = HPCalendarWeekCellReactor(week: self.weekEntity[indexPath.row])
        return weekCell
    }
}



extension HPCalendarWeekReusableView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentSpacing: Int = 32
        return CGSize(width: (Int(collectionView.frame.size.width) - contentSpacing) / 7, height: 40)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

}
