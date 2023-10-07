//
//  ClassInfoViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/08.
//

import UIKit
import HPCommonUI
import HPCommon

class ClassInfoViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 14, left: 0, bottom: UIApplication.shared.safeAreaBottom, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.dataSource = self
            $0.delegate = self
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 121, right: 0)
            $0.register(ClassInfoCollectionViewCell.self, forCellWithReuseIdentifier: "ClassInfoCollectionViewCell")
            $0.register(ClassInfoReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClassInfoReusableView")
        }
    }()
    let text = ["이 수업은 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구",
                "이 수업은 어쩌구저쩌구어쩌구저쩌구",
                "이 수업은 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구 이 수업은 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension ClassInfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        // 타이틀 높이 24, 하단 여백 22, 상단 여백 19
        var height: CGFloat = 24 + 22 + 19
        text.forEach {
            // 디테일 제외 높이 228, 각 셀 사이마다 18 띄우기
            height += $0.heightForView(font: UIFont().fontWithName(type: .regular, size: 11), width: width - 26 - 32) + 228 + 18
        }
        
        // 하단 여백 40
        return CGSize(width: width, height: height + 40 )
    }
}


extension ClassInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassInfoCollectionViewCell", for: indexPath) as? ClassInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(text)
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ClassInfoReusableView",
                for: indexPath
              ) as? ClassInfoReusableView else {return UICollectionReusableView()}
        header.configure(123)
        return header
    }
    
    
}
