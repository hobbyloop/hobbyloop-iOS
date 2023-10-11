//
//  TicketReservationViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/10/09.
//

import UIKit

import HPCommonUI
import RxCocoa
import RxSwift
import RxDataSources
import SnapKit
import Then


public final class TicketReservationViewController: BaseViewController<TicketReservationViewReactor> {
    
    
    private lazy var reservationDataSource: RxCollectionViewSectionedReloadDataSource<TicketReservationSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case .reservationTicketItem:
            guard let ticketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketReservationCell", for: indexPath) as? TicketReservationCell else { return UICollectionViewCell() }
            return ticketCell
        case .reservationNoticeItem:
            guard let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketNoticeCell", for: indexPath) as? TicketNoticeCell else { return UICollectionViewCell() }
            
            return noticeCell
        case .reservationTypeItem:
            guard let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketTypeCell", for: indexPath) as? TicketTypeCell else { return UICollectionViewCell() }
            
            return typeCell
        default:
            return UICollectionViewCell()
        }
        
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        switch dataSource[indexPath] {
        case .reservationNoticeItem:
            guard let noticeReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TicketNoticeReusableView", for: indexPath) as? TicketNoticeReusableView else { return UICollectionReusableView() }
            return noticeReusableView
            
        case .reservationTypeItem:
            guard let typeReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TicketTypeReusableView", for: indexPath) as? TicketTypeReusableView else { return UICollectionReusableView() }
            return typeReusableView
        default:
            return UICollectionReusableView()
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
        $0.register(TicketTypeCell.self, forCellWithReuseIdentifier: "TicketTypeCell")
        $0.register(TicketNoticeReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TicketNoticeReusableView")
        $0.register(TicketTypeReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TicketTypeReusableView")
        $0.collectionViewLayout.register(WhiteBackgroundDecorationView.self, forDecorationViewOfKind: "WhiteBackgroundDecorationView")
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    
    
    
    public override init(reactor: TicketReservationViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(140)
        )
        
        let ticketReservationItem = NSCollectionLayoutItem(
            layoutSize: ticketReservationLayoutSize
        )
        
        let ticketReservationGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.size.width), heightDimension: .absolute(179))
        
        let ticketReservationGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketReservationGroupSize,
            subitem: ticketReservationItem,
            count: 1
        )
        
        let ticketReservationDecorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: "\(WhiteBackgroundDecorationView.self)"
        )
        
        ticketReservationDecorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0)
        
        let ticketReservationSection = NSCollectionLayoutSection(
            group: ticketReservationGroup
        )
        
        ticketReservationSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        ticketReservationSection.decorationItems = [ticketReservationDecorationItem]
        
        
        return ticketReservationSection
    }
    
    
    private func createReservationNoticeLayout() -> NSCollectionLayoutSection? {
        
        let ticketNoticeLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(78)
        )
        
        let ticketNoticeItem = NSCollectionLayoutItem(
            layoutSize: ticketNoticeLayoutSize
        )
        
        let ticketNoticeGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(100)
        )
        
        let ticketNoticeGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: ticketNoticeGroupSize,
            subitem: ticketNoticeItem,
            count: 1
        )
        
        let ticketNoticeDecorationItem = NSCollectionLayoutDecorationItem.background(
            elementKind: "\(WhiteBackgroundDecorationView.self)"
        )
        
        ticketNoticeDecorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0)
        
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
        let ticketTypeLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(330)
        )
        
        let ticketTypeLayoutItem = NSCollectionLayoutItem(
            layoutSize: ticketTypeLayoutSize
        )
        
        let ticketTypeLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketTypeLayoutSize,
            subitems: [ticketTypeLayoutItem]
        )
        
        let ticketTypeDecorationItem = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        
        ticketTypeDecorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0)
        
        let ticketTypeSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(48)
        )
        
        let ticketTypeSection = NSCollectionLayoutSection(group: ticketTypeLayoutGroup)
        
        ticketTypeSection.decorationItems = [ticketTypeDecorationItem]
        ticketTypeSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: ticketTypeSectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        
        ]
        
        return ticketTypeSection
    }
    
    private func createReservationUserInfoLayout() -> NSCollectionLayoutSection? {
        
        
        return nil
    }
    
    
    public override func bind(reactor: Reactor) {
        
        
        Observable
            .just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.pulse(\.$reservationSection)
            .asDriver(onErrorJustReturn: [])
            .drive(reservationCollectionView.rx.items(dataSource: self.reservationDataSource))
            .disposed(by: disposeBag)
        
        
        
        NotificationCenter
            .default.rx
            .notification(.popToViewController)
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        
    }
    
}
