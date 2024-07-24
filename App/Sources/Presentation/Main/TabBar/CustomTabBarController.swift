//
//  CustomTabBarController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/26.
//

import UIKit

import HPCommon
import HPCommonUI

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let homeController = HPNavigationController(
        rootViewController: HomeDIContainer().makeViewController(),
        defaultBarAppearance: UINavigationBarAppearance(),
        scrollBarAppearance: UINavigationBarAppearance()
    )
    
    private let ticketReservationController = HPNavigationController(
        rootViewController: TicketSelectDIContainer().makeViewController(),
        defaultBarAppearance: UINavigationBarAppearance(),
        scrollBarAppearance: UINavigationBarAppearance()
    )
    
    private let dummyView = HPNavigationController(
        rootViewController: TicketDIContainer().makeViewController(),
        defaultBarAppearance: UINavigationBarAppearance(),
        scrollBarAppearance: UINavigationBarAppearance()
    )
    
    
    private let dummyView3 = HPNavigationController(
        rootViewController: UIViewController(),
        defaultBarAppearance: UINavigationBarAppearance(),
        scrollBarAppearance: UINavigationBarAppearance()
    )
    
    private let dummyView4 = HPNavigationController(
        rootViewController: MyPageViewController(reactor: MyPageViewReactor(repository: MyPageViewRepository())),
        defaultBarAppearance: UINavigationBarAppearance(),
        scrollBarAppearance: UINavigationBarAppearance()
    )
    
    private var shapeLayer: CALayer?
    private let font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.tabBar.tintColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
        let systemFontAttributes = [NSAttributedString.Key.font: font]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        
        homeController.tabBarItem.selectedImage = HPCommonUIAsset.homeFilled.image.withRenderingMode(.alwaysOriginal)
        homeController.tabBarItem.title = "홈"
        homeController.tabBarItem.image = HPCommonUIAsset.homeOutlined.image.withRenderingMode(.alwaysOriginal)
        
        dummyView.tabBarItem.selectedImage = HPCommonUIAsset.ticketFilled.image.withRenderingMode(.alwaysOriginal)
        dummyView.tabBarItem.title = "이용권"
        dummyView.tabBarItem.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
        
        
        dummyView3.view.backgroundColor = .blue
        dummyView3.tabBarItem.selectedImage = HPCommonUIAsset.archiveFilled.image.withRenderingMode(.alwaysOriginal)
        dummyView3.tabBarItem.title = "보관함"
        dummyView3.tabBarItem.image = HPCommonUIAsset.archiveOutlined.image.withRenderingMode(.alwaysOriginal)

        dummyView4.tabBarItem.selectedImage = HPCommonUIAsset.myFilled.image.withRenderingMode(.alwaysOriginal)
        dummyView4.tabBarItem.title = "마이페이지"
        dummyView4.tabBarItem.image = HPCommonUIAsset.myOutlined.image.withRenderingMode(.alwaysOriginal)
        
        viewControllers = [homeController, dummyView, ticketReservationController ,dummyView3, dummyView4]
        
        object_setClass(self.tabBar, CustomTabBar.self)
        tabBarAddLine()
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        tabBar.items![2].image = HPCommonUIAsset.menuMiddle.image.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].selectedImage = HPCommonUIAsset.menuMiddle.image.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 10, right: 0)
    }
    
    private func tabBarAddLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        if let oldShapeLayer = self.shapeLayer {
            tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.view.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.view.frame.width, y: self.view.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.view.frame.height))
        path.close()
        
        return path.cgPath
    }
    
}

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = UIApplication.shared.safeAreaBottom + 60
        
        return sizeThatFits
        
    }
    
}
