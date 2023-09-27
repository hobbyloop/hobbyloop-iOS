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
import HPCommonUI

public final class TicketSelectTimeViewController: BaseViewController<TicketSelectTimeViewReactor> {
    
    public var isStyle: CalendarStyle = .bubble {
        didSet {
            if isStyle == .default {
                self.profileCollectionView.collectionViewLayout = montlyProfileCollectionViewLayout
            } else {
                self.profileCollectionView.collectionViewLayout = weeklyprofileCollectionViewLayout
            }
        }
    }
    
    private lazy var profileDataSource: RxCollectionViewSectionedReloadDataSource<TicketInstructorProfileSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .instructorCalendarItem(cellReactor):
            guard let ticketCalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCalendarCell", for: indexPath) as? TicketCalendarCell else { return UICollectionViewCell() }
            ticketCalendarCell.reactor = cellReactor
            
            ticketCalendarCell.delegate = self
            return ticketCalendarCell
            
        case let .instructorProfileItem(cellReactor):
            guard let instructorProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketInstructorProfileCell", for: indexPath) as? TicketInstructorProfileCell else { return UICollectionViewCell() }
            instructorProfileCell.reactor = cellReactor
            return instructorProfileCell
        }
    }
    
    private lazy var weeklyprofileCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, environment in
        let dataSource = self.profileDataSource[section]
        
        switch dataSource {
        case .instructorCalendar:
            return self.createTicketCalendarLayout()
        case .instructorProfile:
            return self.createInstructorProfileLayout()
            
        }
    }
    
    private lazy var montlyProfileCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, environment in
        let dataSource = self.profileDataSource[section]
        switch dataSource {
        case .instructorCalendar:
            return self.createMonthlyTicketCalendarLayout()
        case .instructorProfile:
            return self.createInstructorProfileLayout()
        }
        
    }
    
    
    private lazy var profileCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.isStyle == .bubble ? weeklyprofileCollectionViewLayout : montlyProfileCollectionViewLayout).then {
        
        $0.register(TicketInstructorProfileCell.self, forCellWithReuseIdentifier: "TicketInstructorProfileCell")
        $0.register(TicketCalendarCell.self, forCellWithReuseIdentifier: "TicketCalendarCell")
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    
    override public init(reactor: TicketSelectTimeViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

    private func configure() {
        
        self.view.backgroundColor = HPCommonUIAsset.systemBackground.color
        self.view.addSubview(profileCollectionView)
        
        
        profileCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    
    private func createInstructorProfileLayout() -> NSCollectionLayoutSection {
        
        let instructorProfileLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(self.view.frame.size.width),
            heightDimension: .estimated(285)
        )
        
        let instructorProfileItem = NSCollectionLayoutItem(layoutSize: instructorProfileLayoutSize)
        
        let instructorProfileGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: instructorProfileLayoutSize,
            subitems: [instructorProfileItem]
        )
        
        let instructorProfileSection = NSCollectionLayoutSection(group: instructorProfileGroup)
        
        
        instructorProfileSection.orthogonalScrollingBehavior = .groupPaging
        
        return instructorProfileSection
    }
    
    private func createMonthlyTicketCalendarLayout() -> NSCollectionLayoutSection {
        let ticketCalendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(310)
        )
        
    
        
        let ticketCalendarLayoutItem = NSCollectionLayoutItem(layoutSize: ticketCalendarLayoutSize)
        
        let ticketCalendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketCalendarLayoutSize,
            subitem: ticketCalendarLayoutItem,
            count: 1

        )
        
        let ticketCalendarSection = NSCollectionLayoutSection(group: ticketCalendarLayoutGroup)
        
        return ticketCalendarSection
    }
    
    private func createTicketCalendarLayout() -> NSCollectionLayoutSection {
        
        
        let ticketCalendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(130)
        )
        
    
        
        let ticketCalendarLayoutItem = NSCollectionLayoutItem(layoutSize: ticketCalendarLayoutSize)
        
        let ticketCalendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketCalendarLayoutSize,
            subitem: ticketCalendarLayoutItem,
            count: 1

        )
        
        let ticketCalendarSection = NSCollectionLayoutSection(group: ticketCalendarLayoutGroup)
        
        return ticketCalendarSection
    }
    
    
    
    public override func bind(reactor: TicketSelectTimeViewReactor) {
        
        Observable
            .just(())
            .map {Reactor.Action.viewDidLoad}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$profileSection)
            .asDriver(onErrorJustReturn: [])
            .drive(profileCollectionView.rx.items(dataSource: self.profileDataSource))
            .disposed(by: disposeBag)
                
        
        NotificationCenter
            .default.rx
            .notification(.popToViewController)
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
            

    }
    
}


extension TicketSelectTimeViewController: TicketCalendarDelegate {
    public func didTapCalendarStyleButton(isStyle: CalendarStyle) {
        self.isStyle = isStyle
    }
}
