//
//  TicketCollectionViewCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import UIKit

import RxSwift
import HPCommonUI
import HPDomain
import HPCommon

class TicketCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "TicketTestImage")
    }
    
    private var storeStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private var titleStackView: UIStackView = UIStackView().then {
        $0.spacing = 9
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    private var titleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 20)
    }
    
    private var descriptionLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
    }
    
    public var archiveButton: UIButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.archiveOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setImage(HPCommonUIAsset.archiveFilled.image.withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    private var rightStackView: UIStackView = UIStackView().then {
        $0.spacing = 9
        $0.axis = .vertical
        $0.alignment = .trailing
    }
    
    private var starStackView: UIStackView = UIStackView().then {
        $0.spacing = 5
        $0.axis = .horizontal
    }
    
    private var starImageView: UIImageView = UIImageView().then {
        $0.tintColor = UIColor(red: 255/255, green: 194/255, blue: 0, alpha: 1)
    }
    
    private var starLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
    }
    
    public lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: TicketCollectionViewLayout).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(
            TicketListCollectionViewHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "TicketTableViewHeaderCell"
        )
        $0.register(
            SeparatorView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SeparatorView"
        )
        $0.register(TicketListCell.self, forCellWithReuseIdentifier: "BodyCell")
        $0.collectionViewLayout.register(WhiteBackgroundDecorationView.self, forDecorationViewOfKind: "WhiteBackgroundDecorationView")
        $0.collectionViewLayout.register(SeparatorView.self, forDecorationViewOfKind: "SeparatorView")
        $0.dataSource = self
        $0.delegate = self
    }
    
    private lazy var TicketCollectionViewLayout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { section, _ in
        if section == 0 {
            return self.headerLayout()
        }
        
        return self.separatorLayout()
    }
    
    private func separatorLayout() -> NSCollectionLayoutSection {
        let userInfoProvideLayoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(bounds.width),
            heightDimension: .absolute(1)
        )
        
        let userInfoProvideItem = NSCollectionLayoutItem(layoutSize: userInfoProvideLayoutSize)
        
        let userInfoProvideGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: userInfoProvideLayoutSize,
            subitem: userInfoProvideItem,
            count: 1
        )
        
        userInfoProvideItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        
        let userInfoProvideSection = NSCollectionLayoutSection(group: userInfoProvideGroup)
        
        let benefitsSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(SeparatorView.self)")
        benefitsSectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        userInfoProvideSection.orthogonalScrollingBehavior = .paging
        
        userInfoProvideSection.decorationItems = [benefitsSectionBackground]
        
        return userInfoProvideSection
    }
    
    private func headerLayout() -> NSCollectionLayoutSection {
        
        let benefitsItemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(249),
            heightDimension: .absolute(67)
        )
        
        let benefitsLayoutItem = NSCollectionLayoutItem(layoutSize: benefitsItemLayoutSize)
        
        benefitsLayoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 22,
            bottom: 0,
            trailing: 22
        )
        
        let benefitsGroupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(249),
            heightDimension: .absolute(67)
        )
        
        let benefitsGroupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: benefitsGroupLayoutSize,
            subitems: [benefitsLayoutItem]
        )
        
        let benefitsSection = NSCollectionLayoutSection(
            group: benefitsGroupLayout
        )
        
        let benefitsSectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: "\(WhiteBackgroundDecorationView.self)")
        benefitsSectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0)
        benefitsSection.orthogonalScrollingBehavior = .continuous
        
        benefitsSection.decorationItems = [benefitsSectionBackground]
        
        let benefitsHeaderLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(bounds.width),
            heightDimension: .absolute(34)
        )
        
        let benefitsHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: benefitsHeaderLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
        benefitsHeader.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 22,
            bottom: 0,
            trailing: 22
        )
        
        benefitsSection.boundarySupplementaryItems = [benefitsHeader]
        return benefitsSection
    }
    
    private var data: FacilityInfo?
    public let cellSelect: PublishSubject<Int> = PublishSubject<Int>()
    public var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    private func initLayout() {
        backgroundColor = .white
        
        [imageView, storeStackView, collectionView].forEach {
            addSubview($0)
        }
        
        [titleStackView, rightStackView].forEach {
            storeStackView.addArrangedSubview($0)
        }
        
        [archiveButton, starStackView].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        [titleLabel, descriptionLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [starImageView, starLabel].forEach {
            starStackView.addArrangedSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(262)
        }
        
        storeStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(47)
        }
        
        starImageView.snp.makeConstraints {
            $0.width.height.equalTo(13)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(storeStackView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
    
    public func configure(_ data: FacilityInfo) {
        self.data = data
        imageView.image = UIImage(named: "TicketTestImage")?.withRenderingMode(.alwaysOriginal)
#warning("김진우 - TODO: KingFisher 추가되면 이미지 URL 세팅으로 변경")
        //        imageView.image = data.repImageUrl
        titleLabel.text = data.facilityName
        descriptionLabel.text = data.address
        starLabel.text = String(data.score)
        starImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        archiveButton.isSelected = data.bookmarked
        
    }
}

extension TicketCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5 /*data?.tickets.count ?? 0*/
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyCell", for: indexPath) as? TicketListCell else { return UICollectionViewCell() }
        guard let data else { return cell }
#warning("김진우 - TODO: API 변경 되어서 티켓 관련해서 생성되면 수정 진행")
        switch indexPath.section {
        case 0 :
            cell.configure(data.tickets[0])
        default :
            break
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0 :
            guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "TicketTableViewHeaderCell",
                    for: indexPath
                  ) as? TicketListCollectionViewHeaderCell else {return UICollectionReusableView()}
#warning("김진우 - TODO: API 변경 되어서 티켓 관련해서 생성되면 수정 진행")
            header.configure(data?.tickets.count ?? 0)
            return header
        default :
            guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "SeparatorView",
                    for: indexPath
                  ) as? SeparatorView else {return UICollectionReusableView()}
            return header
        }
        
    }
}

extension TicketCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelect.onNext(indexPath.row)
    }
}

extension TicketCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0 :
            return CGSize(width: bounds.width, height: 34)
        default:
            return CGSize(width: bounds.width, height: 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0 :
            return CGSize(width: bounds.width, height: 67)
        default:
            return CGSize(width: bounds.width, height: 2)
        }
    }
}
