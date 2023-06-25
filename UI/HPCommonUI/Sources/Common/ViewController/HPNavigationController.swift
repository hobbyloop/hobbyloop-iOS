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
    case `default`
}


public protocol HPNavigationProxy {
    var navigationBarAppearance: UINavigationBarAppearance { get }
}


public final class HPNavigationController: UINavigationController, HPNavigationProxy {
    
    public private(set) var navigationBarType: HPNavigationBarType
    
    public override func viewWillLayoutSubviews() {
        
        for customNavigationSubViews in self.navigationBar.subviews {
            for items in customNavigationSubViews.subviews {
                if let largeLabel = items as? UILabel {
                    largeLabel.text = self.navigationBar.topItem?.title
                    largeLabel.numberOfLines = 0
                }
            }
        }
    }
    
    public var navigationBarAppearance: UINavigationBarAppearance
    
    public init(navigationBarType: HPNavigationBarType, rootViewController: UIViewController, navigationBarAppearance: UINavigationBarAppearance) {
        self.navigationBarType = navigationBarType
        self.navigationBarAppearance = navigationBarAppearance
        super.init(rootViewController: rootViewController)
        self.configure(type: navigationBarType)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    public func configure(type: HPNavigationBarType) {
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationBar.tintColor = .systemBackground
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 15.0
        
        navigationBarAppearance.titleTextAttributes = [
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 14),
            .foregroundColor: HPCommonUIAsset.black.color
        ]
        
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 22),
            .foregroundColor: HPCommonUIAsset.lightBlack.color,
            .paragraphStyle: paragraphStyle
        ]
        
        navigationBarAppearance.configureWithTransparentBackground()
        
        switch type {
        case .home:
            self.navigationBar.topItem?.title = "지원님, 반가워요!\n예약된 수업"
        case .ticket:
            self.navigationBar.topItem?.title = "시설 / 이용권 조회\n원하는 시설을 구경하고 이용권을 구매해보세요!"
        case .lessonDetail:
            self.navigationBar.topItem?.title = "3개의 이용권이 있어요\n어떤 이용권을 사용하실건가요?"
        default:
            break

        }
    }
    
    
}
