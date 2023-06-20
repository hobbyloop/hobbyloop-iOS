//
//  UIApplication+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/06/06.
//

import UIKit

public extension UIApplication {
    static var keywindow: UIWindow? {
        return UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    
}
