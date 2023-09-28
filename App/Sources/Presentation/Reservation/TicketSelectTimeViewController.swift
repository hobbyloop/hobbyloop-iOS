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
            DispatchQueue.main.async {
                self.profileCollectionView.collectionViewLayout.invalidateLayout()
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
            
        case .instructorIntroduceItem:
            guard let instructorIntroduceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketInstructorIntroduceCell", for: indexPath) as? TicketInstructorIntroduceCell else { return UICollectionViewCell() }
            
            return instructorIntroduceCell
            
        case .instructorScheduleItem:
            guard let instructorScheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketScheduleCell", for: indexPath) as? TicketScheduleCell else { return UICollectionViewCell() }
            
            return instructorScheduleCell
        }
    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        
        switch dataSource[indexPath] {
        case .instructorScheduleItem:
            guard let ticketScheduleView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TicketScheduleReusableView", for: indexPath) as? TicketScheduleReusableView else { return UICollectionReusableView() }
            return ticketScheduleView
        default:
            return UICollectionReusableView()
        }
    }
    
    private lazy var profileCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, environment in
        let dataSource = self.profileDataSource[section]
        
        switch dataSource {
        case .instructorCalendar:
            if self.isStyle == .default {
                return self.createMonthlyTicketCalendarLayout()
            } else {
                return self.createWeeklyTicketCalendarLayout()
            }
        case .instructorProfile:
            return self.createInstructorProfileLayout()
            
        case .instructorIntroduce:
            return self.createInstructorIntroduceLayout()
            
        case .instructorSchedule:
            return self.createInstructorScheduleLayout()

            
        }
    }
    
    private lazy var profileCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: profileCollectionViewLayout).then {
        
        $0.register(TicketInstructorProfileCell.self, forCellWithReuseIdentifier: "TicketInstructorProfileCell")
        $0.register(TicketCalendarCell.self, forCellWithReuseIdentifier: "TicketCalendarCell")
        $0.register(TicketInstructorIntroduceCell.self, forCellWithReuseIdentifier: "TicketInstructorIntroduceCell")
        $0.register(TicketScheduleCell.self, forCellWithReuseIdentifier: "TicketScheduleCell")
        $0.register(TicketScheduleReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TicketScheduleReusableView")
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
        let ticketMontlyCalendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(310)
        )
        
    
        
        let ticketMonthlyCalendarLayoutItem = NSCollectionLayoutItem(layoutSize: ticketMontlyCalendarLayoutSize)
        
        let ticketMonthlyCalendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketMontlyCalendarLayoutSize,
            subitem: ticketMonthlyCalendarLayoutItem,
            count: 1

        )
        
        let ticketMonthlyCalendarSection = NSCollectionLayoutSection(group: ticketMonthlyCalendarLayoutGroup)
        
        return ticketMonthlyCalendarSection
    }
    
    private func createWeeklyTicketCalendarLayout() -> NSCollectionLayoutSection {
        
        
        let ticketWeeklyCalendarLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(130)
        )
        
    
        
        let ticketWeeklyCalendarLayoutItem = NSCollectionLayoutItem(layoutSize: ticketWeeklyCalendarLayoutSize)
        
        let ticketWeeklyCalendarLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: ticketWeeklyCalendarLayoutSize,
            subitem: ticketWeeklyCalendarLayoutItem,
            count: 1

        )
        
        let ticketWeeklyCalendarSection = NSCollectionLayoutSection(group: ticketWeeklyCalendarLayoutGroup)
        
        return ticketWeeklyCalendarSection
    }
    
    private func createInstructorIntroduceLayout() -> NSCollectionLayoutSection {
        let instructorIntroduceLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(48)
        )
        
        let instructorIntroduceLayoutItem = NSCollectionLayoutItem(layoutSize: instructorIntroduceLayoutSize)
        
        let instructorIntroduceGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: instructorIntroduceLayoutSize,
            subitem: instructorIntroduceLayoutItem,
            count: 1
        )
        
        let instructorIntroduceSection = NSCollectionLayoutSection(group: instructorIntroduceGroup)
        
        return instructorIntroduceSection
        
    }
    
    private func createInstructorScheduleLayout() -> NSCollectionLayoutSection {
        let instructorScheduleLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .estimated(191)
        )
        
        
        let instructorScheduleLayoutItem = NSCollectionLayoutItem(layoutSize: instructorScheduleLayoutSize)
        
        
        let instructorScheduleGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: instructorScheduleLayoutSize,
            subitems: [instructorScheduleLayoutItem]
        )
        
        instructorScheduleGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let instructorScheduleSection = NSCollectionLayoutSection(group: instructorScheduleGroup)
        
        let instructorScheduleSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.view.frame.size.width),
            heightDimension: .absolute(46)
        )
    
        instructorScheduleSection.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: instructorScheduleSectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        instructorScheduleSection.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)
        
        return instructorScheduleSection
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
