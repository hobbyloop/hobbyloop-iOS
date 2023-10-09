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
            guard let ticketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketReservationCell", for: indexPath) as? TicketReservationCell else { return UICollectionViewCell() }
            return ticketCell
        case .reservationNoticeItem:
            guard let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketNoticeCell", for: indexPath) as? TicketNoticeCell else { return UICollectionViewCell() }
            return noticeCell
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
            return self.createReservationNoticeLayout()
        case .reservationType:
            return self.createReservationTypeLayout()
        case .reservationUserInfo:
            return self.createReservationUserInfoLayout()
        }

    }
    
    
    private lazy var reservationCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: reservationCollectionViewLayout).then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
        $0.register(TicketReservationCell.self, forCellWithReuseIdentifier: "TicketReservationCell")
        $0.register(TicketNoticeCell.self, forCellWithReuseIdentifier: "TicketNoticeCell")
        $0.register(TicketNoticeReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TicketNoticeReusableView")
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
    
    
    private func createReservationNoticeLayout() -> NSCollectionLayoutSection? {
        
        let ticketNoticeLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(136)
        )
        
        let ticketNoticeItem = NSCollectionLayoutItem(
            layoutSize: ticketNoticeLayoutSize
        )
        
        let ticketNoticeGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: ticketNoticeLayoutSize,
            subitem: ticketNoticeItem,
            count: 1
        )
        
        let ticketNoticeDecorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: "\(WhiteBackgroundDecorationView.self)"
        )
        
        let ticketNoticeSection = NSCollectionLayoutSection(
            group: ticketNoticeGroup
        )
        
        let ticketNoticeSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(48)
        )
        
        ticketNoticeSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: ticketNoticeSectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        ticketNoticeSection.decorationItems = [ticketNoticeDecorationItem]
        
        return ticketNoticeSection
    }
    
    
    private func createReservationTypeLayout() -> NSCollectionLayoutSection? {
        return nil
    }
    
    private func createReservationUserInfoLayout() -> NSCollectionLayoutSection? {
        
        
        return nil
    }
    
    
    
}
