//
//  TicketViewController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/03.
//

import UIKit
import CoreLocation

import HPCommon
import HPCommonUI
import RxCocoa
import RxSwift

class TicketViewController: BaseViewController<TicketViewReactor> {
    var item = [1, 2, 3, 4]
    lazy var itemObservable = Observable.of(item)
    private var location = PublishSubject<String>()
    private var sortStandard = PublishSubject<SortStandard>()
    let locationManager = CLLocationManager()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 24, left: 10, bottom: 10, right: 10)
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
            $0.automaticallyAdjustsScrollIndicatorInsets = false
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 18, left: 10, bottom: 10, right: 10)
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
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    public override func bind(reactor: TicketViewReactor) {
        
    }
}

extension TicketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCollectionViewCell", for: indexPath) as? TicketCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item)
        
        cell.cellSelect
            .subscribe { event in
                let index = self.item[event.element ?? 0]
                let viewController = TicketDetailViewController(1)
                self.navigationController?.pushViewController(viewController, animated: false)
                self.tabBarController?.tabBar.isHidden = true
            }.disposed(by: disposeBag)
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
        
        header.sortButton
            .rx
            .tap
            .subscribe { _ in
                print("Sort")
            }.disposed(by: header.disposeBag)
        
        sortStandard
            .bind(to: header.sortStandard)
            .disposed(by: header.disposeBag)
        
        location
            .bind(to: header.location)
            .disposed(by: header.disposeBag)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = TicketDetailViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width - 40, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width - 40, height: 365 + CGFloat(100))
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
            showRequestLocationServiceAlert()
            
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
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true)
    }
}
