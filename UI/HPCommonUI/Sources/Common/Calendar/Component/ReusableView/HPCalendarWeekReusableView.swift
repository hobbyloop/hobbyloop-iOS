//
//  HPCalendarWeekReusableView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/23.
//

import UIKit

import SnapKit
import Then

final class HPCalendarWeekReusableView: UICollectionReusableView, UICollectionViewDelegate {

    
    private let weekEntity: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    private lazy var weekCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(HPCalendarWeekCell.self, forCellWithReuseIdentifier: "HPCalendarWeekCell")
        $0.delegate = self
        $0.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        self.addSubview(weekCollectionView)
        weekCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
    
}



extension HPCalendarWeekReusableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weekEntity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let weekCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarWeekCell", for: indexPath) as? HPCalendarWeekCell else { return UICollectionViewCell() }
        weekCell.reactor = HPCalendarWeekCellReactor(week: self.weekEntity[indexPath.row])
        return weekCell
    }
}



extension HPCalendarWeekReusableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentSpacing: Int = 16
        return CGSize(width: (Int(collectionView.frame.size.width) - contentSpacing) / 9, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 0)
    }
}
