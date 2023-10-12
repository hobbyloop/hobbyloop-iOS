//
//  FacilityInfoViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/08.
//

import UIKit

import RxSwift
import HPCommonUI

class FacilityInfoViewController: UIViewController {
    var item = [1, 2, 3, 4]
    var height: CGFloat = 0
    let text = """
balance SUDIO는 강사진과 트레이너들의 체계적인 Pilates & Wegiht Program 제공하는 퍼스널 트레이닝 스튜디오 입니다.
    
Kid, Adult, Senior 연령에 따라, 면밀한 움직임 분석을 통한 체계적인 레슨 및 지속적인 컨디션 캐치를 통한 운동 능력 맞춤 향상, 외부 환경으로 인한 불균형 움직임을 고려한 문적인 Pilates & Wegiht Program을 제공하고 있습니다.   필라테스 강사와 웨이트 트레이너가 함께, 회원님들의 몸을 더 건강하고 빛나는 라인으로 만들어 드리겠습니다.

balance SUDIO는 강사진과 트레이너들의 체계적인 Pilates & Wegiht Program 제공하는 퍼스널 트레이닝 스튜디오 입니다.
    
Kid, Adult, Senior 연령에 따라, 면밀한 움직임 분석을 통한 체계적인 레슨 및 지속적인 컨디션 캐치를 통한 운동 능력 맞춤 향상, 외부 환경으로 인한 불균형 움직임을 고려한 문적인 Pilates & Wegiht Program을 제공하고 있습니다.   필라테스 강사와 웨이트 트레이너가 함께, 회원님들의 몸을 더 건강하고 빛나는 라인으로 만들어 드리겠습니다.
"""
    var openFlag = false
    var workTimeClickEvent = PublishSubject<Void>()
    var disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 121, right: 0)
            $0.register(
                FacilityInfoCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "FacilityInfoCollectionReusableView"
            )
            $0.register(FacilityInfoCollectionAnnouncement.self, forCellWithReuseIdentifier: "FacilityInfoCollectionAnnouncement")
            $0.register(FacilityInfoCollectionCompanyInfo.self, forCellWithReuseIdentifier: "FacilityInfoCollectionCompanyInfo")
            $0.register(FacilityInfoCollectionMapCell.self, forCellWithReuseIdentifier: "FacilityInfoCollectionMapCell")
            $0.register(FacilityInfoCollectionBusiness.self, forCellWithReuseIdentifier: "FacilityInfoCollectionBusiness")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        bind()
    }
    
    private func initLayout() {
        [collectionView].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        collectionView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                self.workTimeClickEvent.onNext(Void())
            }.disposed(by: disposeBag)
    }
    
    public func configure() {
        
    }
}

extension FacilityInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityInfoCollectionAnnouncement", for: indexPath) as? FacilityInfoCollectionAnnouncement else { return UICollectionViewCell() }
            cell.configure(text)
            cell.announcementEvent.bind { [weak self] status in
                guard let self = self else { return }
                openFlag.toggle()
                collectionView.collectionViewLayout.invalidateLayout()
            }.disposed(by: cell.disposeBag)
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityInfoCollectionCompanyInfo", for: indexPath) as? FacilityInfoCollectionCompanyInfo else { return UICollectionViewCell() }
            cell.configure(text)
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityInfoCollectionMapCell", for: indexPath) as? FacilityInfoCollectionMapCell else { return UICollectionViewCell() }
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityInfoCollectionBusiness", for: indexPath) as? FacilityInfoCollectionBusiness else { return UICollectionViewCell() }
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
                withReuseIdentifier: "FacilityInfoCollectionReusableView",
                for: indexPath
              ) as? FacilityInfoCollectionReusableView else {return UICollectionReusableView()}
        header.configure()
        
        header.callClickEvent.subscribe { _ in
            if let url = NSURL(string: "tel://01038856116"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }.disposed(by: header.disposeBag)
        
        header.messageClickEvent.subscribe { _ in
            if let url = NSURL(string: "sms://01038856116"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }.disposed(by: header.disposeBag)
        
        workTimeClickEvent
            .bind(to: header.workTimeClickEvent)
            .disposed(by: header.disposeBag)
        
        header.reviewClickEvent.subscribe { _ in
            
        }.disposed(by: header.disposeBag)
        
        return header
    }
}

extension FacilityInfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 414)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        switch indexPath.row {
        case 0 :
            var height: CGFloat = 0
            if openFlag {
                height = text.heightForView(font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14), width: width - 32)
            }
            
            return CGSize(width: width, height: 140 + height)
        case 1:
            let height = text.heightForView(font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14), width: width - 32)
            
            return CGSize(width: width, height: height + 182)
        case 2 :
            return CGSize(width: width, height: width + 20 + 24 + 20 + 20)
        case 3 :
            return CGSize(width: width, height: 147)
        default :
            return CGSize(width: width, height: 0)
        }
    }
}
