//
//  HPNavigationController.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/06/21.
//

import UIKit

import HPExtensions
import Then
import SnapKit

public enum HPNavigationBarType: Equatable {
    case home
    case ticket
    case lessonDetail
    case none
}


public protocol HPNavigationProxy {
    var rightBarButtonItems: [UIBarButtonItem] { get }
    var leftBarButtonItems: [UIBarButtonItem] { get }
    var navigationBarAppearance: UINavigationBarAppearance { get }
    func setHomeNavigationBarButtonItem() -> Void
    func setTicketNavigationBarButtonItem() -> Void
}


public final class HPNavigationController: UINavigationController, HPNavigationProxy {
    
    public private(set) var navigationBarType: HPNavigationBarType
    
    public var navigationBarAppearance: UINavigationBarAppearance
    public var rightBarButtonItems: [UIBarButtonItem] = []
    public var leftBarButtonItems: [UIBarButtonItem] = []
    
    public init(navigationBarType: HPNavigationBarType,
                rootViewController: UIViewController,
                navigationBarAppearance: UINavigationBarAppearance
    ) {
        self.navigationBarType = navigationBarType
        self.navigationBarAppearance = navigationBarAppearance
        super.init(rootViewController: rootViewController)
        self.configure()
        self.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    public func configure() {
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.configureWithTransparentBackground()
        
        
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationBar.compactAppearance = navigationBarAppearance
        
    }
    
    
    public func setHomeNavigationBarButtonItem() {
        let notificationButton = UIButton(type: .system)
        notificationButton.setImage(HPCommonUIAsset.notificationWhite.image.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(HPCommonUIAsset.search.image.withRenderingMode(.alwaysOriginal), for: .normal)
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
            UIBarButtonItem(image: HPCommonUIAsset.logo.image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        ]
        
        
        
        rightBarButtonItems = [
            notificationbarButtonItem,
            spacerbarButtonItem,
            searchbarButtonItem
        ]
        
        
        self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
        self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
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
        
        self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
        self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
        
    }
}


extension HPNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //TODO: navigationBarType에 따라 NavigationBarButton Item 세팅
        switch navigationBarType {
        case .home:
            setHomeNavigationBarButtonItem()
        case .ticket:
            setTicketNavigationBarButtonItem()
        case .lessonDetail: break
        case .none:
            self.navigationItem.setHidesBackButton(true, animated: true)
            
        }
        
        
    }
}
