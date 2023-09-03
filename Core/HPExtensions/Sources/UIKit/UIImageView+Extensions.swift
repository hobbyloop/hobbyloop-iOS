//
//  UIImageView+Extensions.swift
//  HPExtensions
//
//  Created by 김남건 on 2023/09/02.
//

import UIKit
import SnapKit

public extension UIImageView {
    class func circularImageView(radius: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = radius
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(2 * radius)
            $0.height.equalTo(2 * radius)
        }
        
        return imageView
    }
}
