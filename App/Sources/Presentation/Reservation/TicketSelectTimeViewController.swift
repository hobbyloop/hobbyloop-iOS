//
//  TicketSelectTimeViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/20.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

public final class TicketSelectTimeViewController: UIViewController {
    
    
    private lazy var profileDataSource: RxCollectionViewSectionedReloadDataSource<TicketInstructorProfileSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        return UICollectionViewCell()
    }
    
    private lazy var profileCollectionViewLayout: UICollectionViewCompositionalLayout? = UICollectionViewCompositionalLayout { section, _ in
        
        return nil
    }
    
    
    private lazy var profileCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: profileCollectionViewLayout ?? UICollectionViewLayout()).then {
        
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func createInstructorProfileLayout() -> NSCollectionLayoutSection? {
        
        
        return nil
    }
    
    
}
