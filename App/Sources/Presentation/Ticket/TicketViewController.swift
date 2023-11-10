//
//  TicketViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit
import CoreLocation

import HPDomain
import HPCommon
import HPCommonUI
import RxCocoa
import RxSwift

class TicketViewController: BaseViewController<TicketViewReactor> {
#warning("김진우 - TODO: API 연동 이후 변경할 것")
    private var item: [FacilityInfo?] = []
    private lazy var itemObservable = Observable.of(item)
    private var location = PublishSubject<String>()
    private var sortStandard = PublishSubject<FacilitySortType>()
    private let locationManager = CLLocationManager()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = HPCommonUIAsset.classInfoBackground.color
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: "TicketCollectionViewCell")
            $0.register(
                TicketCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "TicketReusableView"
            )
            
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        collectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    public override func bind(reactor: TicketViewReactor) {
        Observable.just(())
            .debug("debug ViewDidLoad")
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$section)
            .observe(on: MainScheduler.instance)
            .subscribe({ event in
                guard let item = event.element else { return }
                self.item = item
                self.collectionView.collectionViewLayout.invalidateLayout()
            })
            .disposed(by: disposeBag)
        
        sortStandard
            .map { Reactor.Action.didTapSortStandard($0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCollectionViewCell", for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item[indexPath.row]!)
        
        cell.archiveButton.rx
            .tap
            .withUnretained(cell)
            .bind { [weak self] cell, _ in
                guard let self else { return }
                cell.archiveButton.isSelected.toggle()
                print("\(self.item[indexPath.row]!.facilityId)")
                self.reactor?.action.onNext(.didTapFacilityArchive(self.item[indexPath.row]!.facilityId))
            }.disposed(by: cell.disposeBag)
        
        cell.cellSelect
            .subscribe { event in
                let index = self.item[event.element ?? 0]
                let viewController = TicketDetailViewController(.ClassInfo)
                self.navigationController?.pushViewController(viewController, animated: false)
                self.tabBarController?.tabBar.isHidden = true
            }.disposed(by: cell.disposeBag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TicketReusableView",
                for: indexPath
              ) as? TicketCollectionReusableView else {return UICollectionReusableView()}
        header.locationButton.addTarget(self, action: #selector(loactionSettingButtonClick), for: .touchDown)
        
        sortStandard
            .bind(to: header.sortStandard)
            .disposed(by: header.disposeBag)
        
        location
            .bind(to: header.location)
            .disposed(by: header.disposeBag)
        
        header.sortButtonTap
            .subscribe { _ in
                self.tabBarController?.tabBar.isHidden = true
                
                let sheet = BottomSheetView()
                self.view.addSubview(sheet)
                sheet.snp.makeConstraints {
                    $0.leading.trailing.bottom.top.equalToSuperview()
                }
                
                sheet.configure(303) { frontView, bar in
                    let sortType = FacilitySortType.allCases.map{$0.rawValue}
                    let typeObserver: Observable<[String]> = Observable.of(sortType)
                    let tableView = UITableView()
                    tableView.register(SortTableViewCell.self, forCellReuseIdentifier: "SortTableViewCell")
                    typeObserver.bind(to: tableView.rx.items) { tableview, index, element -> UITableViewCell in
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SortTableViewCell") as? SortTableViewCell else { return UITableViewCell() }
                        cell.titleStting(element)
                        return cell
                    }.disposed(by: self.disposeBag)
                    
                    frontView.addSubview(tableView)
                    
                    tableView.snp.makeConstraints {
                        $0.top.equalTo(bar.snp.bottom)
                        $0.leading.trailing.equalToSuperview()
                        $0.bottom.equalToSuperview().inset(33)
                    }
                    
                    tableView.rx.itemSelected.bind { index in
                        self.sortStandard.onNext(FacilitySortType.allCases[index.row])
                        sheet.removeFromSuperview()
                        self.tabBarController?.tabBar.isHidden = false
                        print("뷰 삭제")
                    }.disposed(by: self.disposeBag)
                }
            }.disposed(by: header.disposeBag)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = TicketDetailViewController(.FacilityInfo)
        self.navigationController?.pushViewController(viewController, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width, height: 402 + CGFloat(68))
    }
}

extension TicketViewController: CLLocationManagerDelegate {
    
    @objc func loactionSettingButtonClick() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            self.tabBarController?.tabBar.isHidden = true
            let buttonView = TwoButtonView()
            buttonView.configure(title: "위치정보 사용 설정을 허용 해주세요",
                                 subscribe: "가까운 시설을 찾아드릴게요!\n하비루프의 위치정보 접근 권한을 허용하러 갈까요?",
                                 image: HPCommonUIAsset.settingOutlind.image
                .withRenderingMode(.alwaysOriginal)
                .imageWith(newSize: CGSize(width: 44, height: 44))
                .withTintColor(HPCommonUIAsset.deepOrange.color),
                                 leftButton_St: "다음에 하기",
                                 rightButton_St: "설정으로 이동"
            )
            
            view.addSubview(buttonView)
            
            buttonView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
            
            buttonView.leftButton.rx
                .tap
                .bind { _ in
                    buttonView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                }.disposed(by: disposeBag)
            
            buttonView.rightButton.rx
                .tap
                .bind { [weak self] _ in
                    guard let `self` else { return }
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                    buttonView.removeFromSuperview()
                    self.tabBarController?.tabBar.isHidden = false
                }.disposed(by: disposeBag)
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            let geocoder = CLGeocoder()
            
            let location = self.locationManager.location
            
            if location != nil {
                geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                    if error != nil {
                        return
                    }
                    if let placemark = placemarks?.first {
                        var address = ""
                        
                        if let locality = placemark.locality {
                            address = "\(address) \(locality)"
                            print(locality) // 대구광역시
                        }
                        
                        if let thoroughfare = placemark.subLocality {
                            address = "\(address) \(thoroughfare)"
                            print(thoroughfare) // 동인동4가
                        }
                        
                        self.location.onNext(address)
                    }
                }
            }
            
            locationManager.stopUpdatingLocation()
            
        default:
            print("Default")
        }
    }
}
