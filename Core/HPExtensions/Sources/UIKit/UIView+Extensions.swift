//
//  UIView+Extensions.swift
//  HPFoundation
//
//  Created by Kim dohyun on 2023/05/28.
//

import UIKit


public extension UIView {
    
    func makeDashedBorder(start: CGPoint, end: CGPoint, color: CGColor) {
        let lineDashPatterns: [[NSNumber]] = [[8,8]]
        for (_, lineDashPattern) in lineDashPatterns.enumerated() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            shapeLayer.lineDashPattern = lineDashPattern
            
            let path = CGMutablePath()
            
            path.addLines(between: [start, end])
            
            shapeLayer.path = path

            layer.addSublayer(shapeLayer)
        }
    }
    
    func makeUnderLineBorder(_ color: CGColor, width: CGFloat) {
        let layer = CALayer()

        layer.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.width, height: 1)
        layer.borderColor = color
        layer.borderWidth = width

        self.layer.addSublayer(layer)
        self.layer.masksToBounds = true


    }
}
