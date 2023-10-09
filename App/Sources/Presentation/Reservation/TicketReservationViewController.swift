//
//  TicketReservationViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import UIKit

import HPCommonUI
import RxDataSources
import SnapKit
import Then


public final class TicketReservationViewController: UIViewController {
    
    
    private lazy var reservationDataSource: RxCollectionViewSectionedReloadDataSource<TicketReservationSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .reservationTicketItem:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
        
    }
    
    

    private lazy var reservationCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        let dataSource = self.reservationDataSource[section]

        switch dataSource {
        case .reservationTicket:
            return self.createReservationTicketLayout()
        case .reservationNotice:
            return self.createReservationNoticteLayout()
        case .reservationType:
            return self.createReservationTypeLayout()
        case .reservationUserInfo:
            return self.createReservationUserInfoLayout()
        }

    }
    
    
    private lazy var reservationCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: reservationCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        self.view.addSubview(reservationCollectionView)
        
        reservationCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    private func createReservationTicketLayout() -> NSCollectionLayoutSection {
        
        let ticketReservationLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(179)
        )
        
        let ticketReservationItem = NSCollectionLayoutItem(
            layoutSize: ticketReservationLayoutSize
        )
        
        let ticketReservationGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketReservationLayoutSize,
            subitem: ticketReservationItem,
            count: 1
        )
        
        let ticketReservationDecorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: "\(WhiteBackgroundDecorationView.self)"
        )
        
        let ticketReservationSection = NSCollectionLayoutSection(
            group: ticketReservationGroup
        )
        
        ticketReservationSection.decorationItems = [ticketReservationDecorationItem]
        
        
        return ticketReservationSection
    }
    
    
    private func createReservationNoticteLayout() -> NSCollectionLayoutSection? {
        
        return nil
    }
    
    
    private func createReservationTypeLayout() -> NSCollectionLayoutSection? {
        return nil
    }
    
    private func createReservationUserInfoLayout() -> NSCollectionLayoutSection? {
        
        
        return nil
    }
    
    
    
}
