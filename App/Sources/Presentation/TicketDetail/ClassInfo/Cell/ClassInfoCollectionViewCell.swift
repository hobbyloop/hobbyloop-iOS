//
//  ClassInfoCollectionViewCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/21.
//

import UIKit
import HPCommonUI

class ClassInfoCollectionViewCell: UICollectionViewCell {
    private lazy var titleStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 7
    }
    
    private lazy var titleImage: UIImageView = UIImageView().then {
        let size = CGSize(width: 24, height: 24)
        $0.image = HPCommonUIAsset.ticketOutlined.image.imageWith(newSize: size)
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "예약 가능 수업"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
            $0.dataSource = self
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
            $0.register(ReservationCollectionCell.self, forCellWithReuseIdentifier: "ReservationCollectionCell")
        }
    }()
    
    var text: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        backgroundColor = .white
        
        [titleStackView, collectionView].forEach {
            addSubview($0)
        }
        
        [titleImage, titleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(17)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleStackView.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
        }
    }
    
    public func configure(_ text: [String]) {
        self.text = text
    }
}

extension ClassInfoCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.width - 32
        let height = text[indexPath.row].heightForView(font: UIFont().fontWithName(type: .regular, size: 11), width: width - 26)
        return CGSize(width: width, height: height + 228)
    }
    
}


extension ClassInfoCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationCollectionCell", for: indexPath) as? ReservationCollectionCell else { return UICollectionViewCell() }
        cell.configure(text[indexPath.row])
        return cell
    }
    
}
