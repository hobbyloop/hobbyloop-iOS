//
//  TicketTableViewCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/10.
//

import UIKit

import RxSwift

class TicketTableViewCell: UITableViewCell {
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = .init(width: 205, height: 67)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(TicketViewFooterCell.self, forCellWithReuseIdentifier: "BodyCell")
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.dataSource = self
            $0.delegate = self
        }
    }()
    
    public let cellSelect: PublishSubject<Int> = PublishSubject<Int>()
    
    var data: [Int]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initLayout() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public func configure(_ data: [Int]) {
        self.data = data
    }
    
}

extension TicketTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyCell", for: indexPath) as? TicketViewFooterCell else { return UICollectionViewCell() }
        cell.configure("6:1 그룹레슨 30회")
        return cell
    }
}

extension TicketTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelect.onNext(indexPath.row)
    }
}
