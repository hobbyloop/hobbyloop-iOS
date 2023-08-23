//
//  HPCalendarWeekReusableView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/23.
//

import UIKit



final class HPCalendarWeekReusableView: UICollectionReusableView {

    
    private let weekEntity: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 40, height: 40)
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 10
    }
    
    private lazy var weekCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(HPCalendarWeekCell.self, forCellWithReuseIdentifier: "HPCalendarWeekCell")
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
        
        weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
    }
    
}



extension HPCalendarWeekReusableView: UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.weekEntity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let weekCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HPCalendarWeekCell", for: indexPath) as? HPCalendarWeekCell else { return UICollectionViewCell() }
        weekCell.reactor = HPCalendarWeekCellReactor(week: self.weekEntity[indexPath.item])
        return weekCell
    }
}
