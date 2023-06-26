//
//  HPNavigationController.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/06/21.
//

import UIKit

import HPExtensions
import Then

public enum HPNavigationBarType: Equatable {
    case home
    case ticket
    case lessonDetail
    case none
}


public protocol HPNavigationProxy {
    var navigationBarAppearance: UINavigationBarAppearance { get }
}


public final class HPNavigationController: UINavigationController, HPNavigationProxy {
    
    public private(set) var navigationBarType: HPNavigationBarType
    
    public var navigationBarAppearance: UINavigationBarAppearance
    
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
        self.navigationBar.compactAppearance = navigationBarAppearance
        
    }
    
    
}


extension HPNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        var rightBarButtonItems: [UIBarButtonItem]
        var leftBarButtonItems: [UIBarButtonItem]
        //TODO: navigationBarType에 따라 NavigationBarButton Item 세팅
        switch navigationBarType {
        case .home:
            leftBarButtonItems = [
                UIBarButtonItem(image: HPCommonUIAsset.logo.image, style: .plain, target: nil, action: nil)
            ]
            
            
            
            rightBarButtonItems = [
                UIBarButtonItem(image: HPCommonUIAsset.search.image, style: .plain, target: nil, action: nil),
                UIBarButtonItem(image: HPCommonUIAsset.notification.image, style: .plain, target: nil, action: nil)
            ]
            
            self.navigationBar.topItem?.leftBarButtonItems = leftBarButtonItems
            self.navigationBar.topItem?.rightBarButtonItems = rightBarButtonItems
            
        case .ticket: break
        case .lessonDetail: break
        case .none:
            self.navigationItem.setHidesBackButton(true, animated: true)
            
        }
        
        
    }
}
