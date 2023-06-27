//
//  UITabBar+Extension.swift
//  HPExtensions
//
//  Created by 김진우 on 2023/05/31.
//

import UIKit

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 120
        return sizeThatFits
    }
}
