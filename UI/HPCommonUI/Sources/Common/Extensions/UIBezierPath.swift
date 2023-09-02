//
//  UIBazierPath.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/24.
//

import UIKit

public extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x + abs(topLeftRadius), y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        // 1. top right corner
        let topRightCurveStart = CGPoint(x: topRight.x - abs(topRightRadius), y: topRight.y)
        let topRightCurveEnd = CGPoint(x: topRight.x, y: topRight.y + abs(topRightRadius))
        let topRightCurveControl = topRightRadius > .zero ?
                                        CGPoint(x: topRight.x, y: topRight.y) :
                                        CGPoint(x: topRight.x - abs(topRightRadius), y: topRight.y + abs(topRightRadius))
        
        if topRightRadius != .zero {
            path.addLine(to: topRightCurveStart)
            path.addCurve(to:  topRightCurveEnd, control1: topRightCurveControl, control2: topRightCurveEnd)
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        
        // 2. bottom right corner
        let bottomRightCurveStart = CGPoint(x: bottomRight.x, y: bottomRight.y - abs(bottomRightRadius))
        let bottomRightCurveEnd = CGPoint(x: bottomRight.x - abs(bottomRightRadius), y: bottomRight.y)
        let bottomRightCurveControl = bottomRightRadius > .zero ?
                                        CGPoint(x: bottomRight.x, y: bottomRight.y) :
                                        CGPoint(x: bottomRight.x - abs(bottomRightRadius), y: bottomRight.y - abs(bottomRightRadius))
        
        
        if bottomRightRadius != .zero{
            path.addLine(to: bottomRightCurveStart)
            path.addCurve(to: bottomRightCurveEnd,
                          control1: bottomRightCurveControl,
                          control2: bottomRightCurveEnd)
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        // 3. bottom left corner
        let bottomLeftCurveStart = CGPoint(x: bottomLeft.x + abs(bottomLeftRadius), y: bottomLeft.y)
        let bottomLeftCurveEnd = CGPoint(x: bottomLeft.x, y: bottomLeft.y - abs(bottomLeftRadius))
        let bottomLeftCurveControl = bottomLeftRadius > .zero ?
                                        CGPoint(x: bottomLeft.x, y: bottomLeft.y) :
                                        CGPoint(x: bottomLeft.x + abs(bottomLeftRadius), y: bottomLeft.y - abs(bottomLeftRadius))
        
        if bottomLeftRadius != .zero{
            path.addLine(to: bottomLeftCurveStart)
            path.addCurve(to: bottomLeftCurveEnd,
                          control1: bottomLeftCurveControl,
                          control2: bottomLeftCurveEnd)
        }  else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        // 4. top left corner
        let topLeftCurveStart = CGPoint(x: topLeft.x, y: topLeft.y + abs(topLeftRadius))
        let topLeftCurveEnd = CGPoint(x: topLeft.x + abs(topLeftRadius), y: topLeft.y)
        let topLeftCurveControl = topLeftRadius > .zero ?
                                        CGPoint(x: topLeft.x, y: topLeft.y) :
                                        CGPoint(x: topLeft.x + abs(topLeftRadius), y: topLeft.y + abs(topLeftRadius))
        
        if topLeftRadius != .zero{
            path.addLine(to: topLeftCurveStart)
            path.addCurve(to: topLeftCurveEnd, control1: topLeftCurveControl, control2: topLeftCurveEnd)
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
