//
//  HPNavigationController.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/06/21.
//

import UIKit


public enum HPNavigationBarType: Equatable {
    case home
    case ticket
    case ticketDetail
    case `default`
}


public protocol HPNavigationProxy {
    var navigationBarAppearance: UINavigationBarAppearance { get }
}


public final class HPNavigationController: UINavigationController, HPNavigationProxy {
    
    public private(set) var navigationBarType: HPNavigationBarType
    public var navigationBarAppearance: UINavigationBarAppearance
    
    public init(navigationBarType: HPNavigationBarType, rootViewController: UIViewController, navigationBarAppearance: UINavigationBarAppearance) {
        self.navigationBarType = navigationBarType
        self.navigationBarAppearance = navigationBarAppearance
        super.init(rootViewController: rootViewController)
        self.configure()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        self.navigationBar.prefersLargeTitles = true
        navigationBarAppearance.titleTextAttributes = [
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 14),
            .foregroundColor: HPCommonUIAsset.black.color
        ]
        
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 22),
            .foregroundColor: HPCommonUIAsset.lightBlack.color,
        ]
        
        navigationBarAppearance.configureWithTransparentBackground()
        
        self.navigationBar.tintColor = .systemBackground
        self.navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        
    }
    
    
}
