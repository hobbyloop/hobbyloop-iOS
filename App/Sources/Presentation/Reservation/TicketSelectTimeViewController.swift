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
    
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.systemBackground.color
    }
    
    private let ticketStyleButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.calendarOutlined.image, for: .normal)
        $0.setImage(HPCommonUIAsset.calendarFilled.image, for: .selected)
    }
    
    private let calendarContentView = HPCalendarContentView().then {
        $0.backgroundColor = HPCommonUIAsset.white.color
    }
        
    private lazy var ticketCalendarView: HPCalendarView = HPCalendarView(reactor: HPCalendarViewReactor(calendarConfigureProxy: HPCalendarProxyBinder()), isStyle: .bubble).then {
        $0.color = HPCommonUIAsset.white.color
    }
    
    
    private lazy var profileDataSource: RxCollectionViewSectionedReloadDataSource<TicketInstructorProfileSection> = .init { dataSource, collectionView, indexPath, sectionItem in
        
        switch sectionItem {
        case let .instructorProfileItem(cellReactor):
            guard let instructorProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketInstructorProfileCell", for: indexPath) as? TicketInstructorProfileCell else { return UICollectionViewCell() }
            instructorProfileCell.reactor = cellReactor
            
            return instructorProfileCell
        }
    }
    
    private lazy var profileCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        
        return self.createInstructorProfileLayout()
    }
    
    
    private lazy var profileCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: profileCollectionViewLayout).then {
        
        $0.register(TicketInstructorProfileCell.self, forCellWithReuseIdentifier: "TicketInstructorProfileCell")
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var ticketScheduleCollectionView: UICollectionViewCompositionalLayout? = UICollectionViewCompositionalLayout { _, _ in
        
        return nil
    }
    
    private lazy var introduceProfileView: TicketIntroduceView = TicketIntroduceView().then {
        $0.backgroundColor = HPCommonUIAsset.white.color
        
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
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        containerView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide)
        }
        
        
        
        [ticketCalendarView, profileCollectionView, introduceProfileView, ticketStyleButton].forEach {
            containerView.addSubview($0)
        }
        
        
        ticketStyleButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
            $0.right.equalToSuperview().offset(-26)
            $0.width.height.equalTo(24)
        }
        
        profileCollectionView.snp.makeConstraints {
            $0.top.equalTo(ticketCalendarView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(285)
        }
        
        introduceProfileView.snp.makeConstraints {
            $0.top.equalTo(profileCollectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48)
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
        
        
        instructorProfileSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return instructorProfileSection
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
        
        ticketStyleButton
            .rx.tap
            .map { Reactor.Action.didTapCalendarStyleButton}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.isStyle == .bubble ? false : true }
            .bind(to: ticketStyleButton.rx.isSelected)
            .disposed(by: disposeBag)
            
        
        reactor.state
            .map { $0.isStyle }
            .observe(on: MainScheduler.instance)
            .bind(onNext: { isStyle in
                self.ticketCalendarView.isStyle = isStyle
                //TODO: Global Action 으로 처리하도록 변경
                self.ticketCalendarView.reactor?.action.onNext(.changeCalendarStyle(isStyle))
                if isStyle == .default {
                    self.ticketCalendarView.calendarContentView = self.calendarContentView
                    self.ticketCalendarView.snp.updateConstraints {
                        $0.height.equalTo(301)
                    }
                } else {
                    self.ticketCalendarView.calendarContentView = nil
                    self.ticketCalendarView.snp.remakeConstraints {
                        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
                        $0.left.right.equalToSuperview()
                        $0.height.equalTo(125)
                    }
                    
                }
                self.ticketCalendarView.layoutIfNeeded()
                
            }).disposed(by: disposeBag)
    }
    
}
