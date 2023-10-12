//
//  HPNavigationController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/22.
//

import UIKit

import HPCommonUI
import HPExtensions
import Then
import SnapKit
import RxSwift
import RxCocoa


public protocol HPNavigationProxy {
    
    var disposeBag: DisposeBag { get }
    var rightBarButtonItems: [UIBarButtonItem] { get }
    var leftBarButtonItems: [UIBarButtonItem] { get }
    var scrollBarAppearance: UINavigationBarAppearance { get }
    var defaultBarAppearance: UINavigationBarAppearance { get }
    func setHomeNavigationBarButtonItem() -> Void
    func setTicketNavigationBarButtonItem() -> Void
    func setTicketDetailNavigationBarButtonItem() -> Void
}


public final class HPNavigationController: UINavigationController, HPNavigationProxy {
        
    public var disposeBag: DisposeBag = DisposeBag()
    public var defaultBarAppearance: UINavigationBarAppearance
    public var scrollBarAppearance: UINavigationBarAppearance
    public var rightBarButtonItems: [UIBarButtonItem] = []
    public var leftBarButtonItems: [UIBarButtonItem] = []
    
    public init(rootViewController: UIViewController,
                defaultBarAppearance: UINavigationBarAppearance,
                scrollBarAppearance: UINavigationBarAppearance
    ) {
        self.defaultBarAppearance = defaultBarAppearance
        self.scrollBarAppearance = scrollBarAppearance
        super.init(rootViewController: rootViewController)
        self.configure()
        self.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    public func configure() {
        
        scrollBarAppearance.configureWithTransparentBackground()
        scrollBarAppearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
        scrollBarAppearance.shadowImage = UIImage()
        scrollBarAppearance.backgroundImage = UIImage()
        
        defaultBarAppearance.backgroundColor = .clear
        defaultBarAppearance.configureWithTransparentBackground()

        
        self.navigationBar.scrollEdgeAppearance = defaultBarAppearance
        self.navigationBar.standardAppearance = scrollBarAppearance
        self.navigationBar.compactAppearance = defaultBarAppearance
        
    }
    
    
    public func setHomeNavigationBarButtonItem() {
        
        defaultBarAppearance.backgroundColor = HPCommonUIAsset.systemBackground.color
        
        let notificationButton = UIButton(type: .system)
        notificationButton.setImage(HPCommonUIAsset.notification.image.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(HPCommonUIAsset.searchBlack.image.withRenderingMode(.alwaysOriginal), for: .normal)
        let notificationbarButtonItem = UIBarButtonItem(customView: notificationButton)
        let searchbarButtonItem = UIBarButtonItem(customView: searchButton)
        let spacerbarButtonItem = UIBarButtonItem(systemItem: .fixedSpace)
        spacerbarButtonItem.width = 13
        
        notificationbarButtonItem.customView?.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        searchbarButtonItem.customView?.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        
        leftBarButtonItems = [
            UIBarButtonItem(image: HPCommonUIAsset.hobbyloop.image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        ]
        
        
        
        rightBarButtonItems = [
            notificationbarButtonItem,
            spacerbarButtonItem,
            searchbarButtonItem
        ]
        
        
        self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
        self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
        self.navigationBar.compactAppearance = defaultBarAppearance
        self.navigationBar.scrollEdgeAppearance = defaultBarAppearance
    }
    
    
    
    public func setTicketNavigationBarButtonItem() {
        //TODO: TicketDetailViewController일 경우 RightBarButtonitem Reset
        
        
        let notificationButton = UIButton(type: .system)
        notificationButton.setImage(HPCommonUIAsset.notification.image.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(HPCommonUIAsset.searchBlack.image.withRenderingMode(.alwaysOriginal), for: .normal)
        let notificationbarButtonItem = UIBarButtonItem(customView: notificationButton)
        let searchbarButtonItem = UIBarButtonItem(customView: searchButton)
        let spacerbarButtonItem = UIBarButtonItem(systemItem: .fixedSpace)
        spacerbarButtonItem.width = 13
        
        
        leftBarButtonItems = [
            UIBarButtonItem(image: HPCommonUIAsset.logo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        ]
        
        
        rightBarButtonItems = [
            notificationbarButtonItem,
            spacerbarButtonItem,
            searchbarButtonItem
        ]
        
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
        self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
        
    }
    
    public func setTicketDetailNavigationBarButtonItem() {
        let backButtonItem = UIButton(type: .system)
        let bookMarkButtonItem = UIButton(type: .system)
        let spacerbarButtonItem = UIBarButtonItem(systemItem: .fixedSpace)
        let customDotButtonItem = UIButton(type: .system)
        
        
        backButtonItem.setImage(HPCommonUIAsset.leftArrow.image.withRenderingMode(.alwaysOriginal), for: .normal)
        bookMarkButtonItem.setImage(HPCommonUIAsset.unArchive.image.withRenderingMode(.alwaysOriginal), for: .normal)
        customDotButtonItem.setImage(HPCommonUIAsset.dot.image.withRenderingMode(.alwaysOriginal), for: .normal)
        spacerbarButtonItem.width = 13
        
        backButtonItem
            .rx.tap
            .bind(onNext: {
                NotificationCenter.default.post(name: .popToViewController, object: nil)
            }).disposed(by: disposeBag)
        
        leftBarButtonItems = [
            UIBarButtonItem(customView: backButtonItem)
        ]
        
        rightBarButtonItems = [
            UIBarButtonItem(customView: bookMarkButtonItem),
            spacerbarButtonItem,
            UIBarButtonItem(customView: customDotButtonItem)
        ]
        
        self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
        self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
        
        
    }
}


extension HPNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        switch viewController {
        case is HomeViewController:
            setHomeNavigationBarButtonItem()
        case is TicketViewController:
            setTicketNavigationBarButtonItem()
        case is TicketDetailViewController:
            setTicketDetailNavigationBarButtonItem()
            
        default:
            configure()
        }
        
        
    }
}


