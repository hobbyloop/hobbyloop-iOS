//
//  CustomTabBarController.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/26.
//

import UIKit

import HPCommonUI

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let firstVC = CustomNavigationViewController(rootViewController: HomeViewController())
    private let dummyView = CustomNavigationViewController(rootViewController: UIViewController())
    private let dummyView2 = CustomNavigationViewController(rootViewController: UIViewController())
    private let dummyView3 = CustomNavigationViewController(rootViewController: UIViewController())
    private let dummyView4 = CustomNavigationViewController(rootViewController: UIViewController())
    
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
        
        firstVC.tabBarItem.selectedImage = UIImage(named: "Home_filled")
        firstVC.tabBarItem.title = "홈"
        firstVC.tabBarItem.image = UIImage(named: "Home_outlined")
        
        dummyView.tabBarItem.selectedImage = UIImage(named: "Ticket")
        dummyView.view.backgroundColor = .gray
        dummyView.tabBarItem.title = "이용권"
        dummyView.tabBarItem.image = UIImage(named: "Ticket")
        
        dummyView2.view.backgroundColor = .red
        dummyView2.tabBarItem.title = "수업예약"
        
        dummyView3.view.backgroundColor = .blue
        dummyView3.tabBarItem.selectedImage = UIImage(named: "Archive_filled")
        dummyView3.tabBarItem.title = "보관함"
        dummyView3.tabBarItem.image = UIImage(named: "Archive_outlined")

        dummyView4.tabBarItem.selectedImage = UIImage(named: "My_filled")
        dummyView4.view.backgroundColor = .green
        dummyView4.tabBarItem.title = "마이페이지"
        dummyView4.tabBarItem.image = UIImage(named: "My_outlined")
        
        viewControllers = [firstVC, dummyView, dummyView2, dummyView3, dummyView4]
        
        object_setClass(self.tabBar, CustomTabBar.self)
        setupMiddleButton()
        tabBarAddLine()
    }
    
    private func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        let image = UIImage(named: "Calendar_outlined")?.withRenderingMode(.alwaysTemplate)
        let selectImage = UIImage(named: "Calendar_filled")?.withRenderingMode(.alwaysTemplate)
        //
        menuButton.contentMode = .scaleAspectFill
        //shadows
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        menuButton.layer.shadowOpacity = 0.25
        //
        menuButton.setImage(image, for: .normal)
        menuButton.setBackgroundImage(UIImage(named: "Circle_Orange"), for: .normal)
        menuButton.setImage(selectImage, for: .selected)
        menuButton.tintColor = .white
        menuButton.layer.cornerRadius = menuButtonFrame.height
        view.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction(_ sender: UIButton) {
        selectedIndex = 2
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
        
        path.move(to: CGPoint(x: 0, y: 5))
        path.addLine(to: CGPoint(x: self.view.frame.width, y: 5))
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
