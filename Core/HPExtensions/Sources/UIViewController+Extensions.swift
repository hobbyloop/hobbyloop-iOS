//
//  UIViewController+Extensions.swift
//  HPExtensions
//
//  Created by 김남건 on 6/30/24.
//

import UIKit

public extension UIViewController {
    func setRootViewController(_ vc: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.rootViewController = vc
        }
    }
}
