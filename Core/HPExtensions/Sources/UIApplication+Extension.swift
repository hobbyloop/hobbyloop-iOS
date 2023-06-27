//
//  UIApplication+Extension.swift
//  HPExtensions
//
//  Created by 김진우 on 2023/05/28.
//

import UIKit

extension UIApplication {
    public var safeAreaTop: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return 20 }
        return window.safeAreaInsets.top
    }
    
    public var safeAreaBottom: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return 20 }
        return window.safeAreaInsets.bottom
    }
    
    public var viewFrame: CGSize {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return CGSize(width: 0, height: 0) }
        return window.frame.size
    }
}

extension UIApplication {
    public class func getMostTopViewController(base: UIViewController? = nil) -> UIViewController? {
        var baseVC: UIViewController?
        if base != nil {
            baseVC = base
        }
        else {
            if #available(iOS 13, *) {
                baseVC = (UIApplication.shared.connectedScenes
                            .compactMap { $0 as? UIWindowScene }
                            .flatMap { $0.windows }
                            .first { $0.isKeyWindow })?.rootViewController
            }
            else {
                baseVC = UIApplication.shared.keyWindow?.rootViewController
            }
        }
        
        if let naviController = baseVC as? UINavigationController {
            return getMostTopViewController(base: naviController.visibleViewController)

        } else if let tabbarController = baseVC as? UITabBarController, let selected = tabbarController.selectedViewController {
            return getMostTopViewController(base: selected)

        } else if let presented = baseVC?.presentedViewController {
            return getMostTopViewController(base: presented)
        }
        return baseVC
    }
}
