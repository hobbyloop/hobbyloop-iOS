//
//  SelectCategoryCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 6/5/24.
//

import UIKit

import HPCommonUI

public final class SelectCategoryCell: UICollectionViewCell {
    
    private let eventView: UIView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    private let testLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        $0.text = "안녕하세요, 김하비님"
        $0.numberOfLines = 1
    }
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [categoryCollectionView, eventView].forEach {
            self.addSubview($0)
        }
        
        eventView.addSubview(testLabel)
        
        testLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        eventView.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.top.equalTo(eventView.snp.bottom).offset(32)
            $0.bottom.equalToSuperview()
        }
    }
    
}

extension SelectCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 80)
    }
    
    
}
