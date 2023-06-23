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



public final class HPNavigationController: UINavigationController {
    
    public private(set) var navigationBarType: HPNavigationBarType
    
    public init(navigationBarType: HPNavigationBarType, rootViewController: UIViewController) {
        self.navigationBarType = navigationBarType
        super.init(rootViewController: rootViewController)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        self.navigationBar.prefersLargeTitles = true
        
        
    }
    
    
    private func setNavigationBarItem(type: HPNavigationBarType) {

    }
    
}
