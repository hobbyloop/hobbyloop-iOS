//
//  TicketViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit

import HPCommon
import HPCommonUI
import RxCocoa
import RxSwift

class TicketViewController: MainBaseViewController<TicketViewReactor> {
    var item = [1, 2, 3, 4]
    lazy var itemObservable = Observable.of(item)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 24, left: 10, bottom: 10, right: 10)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            view.addSubview($0)
            guard let headerView else { return }
            view.bringSubviewToFront(headerView)
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.contentInset = UIEdgeInsets(top: 18, left: 10, bottom: 10, right: 10)
            $0.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: "TicketCollectionViewCell")
            $0.register(
                TicketCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "TicketReusableView"
            )
            
            
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = HeaderView(type: headerType)
        configure()
    }
    
    override func configure() {
        super.configure()
        
        collectionView.snp.makeConstraints {
            guard let headerView else { return }
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
        }
        //
        //        itemObservable
        //            .observe(on: MainScheduler.instance)
        //            .bind(to: collectionView.rx.items) { collectionView, row, item in
        //                let cell = UICollectionViewCell()
        //                cell.backgroundColor = .blue
        //                return cell
        //            }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    public override func bind(reactor: TicketViewReactor) {
        
    }
}

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCollectionViewCell", for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TicketReusableView",
                for: indexPath
              ) as? TicketCollectionReusableView else {return UICollectionReusableView()}
        return header
    }
}

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width - 40, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width - 40, height: 365 + CGFloat(item.count * 72 + 22))
    }
}
