//
//  TicketTemplateView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/25.
//

import UIKit

public final class TicketTemplateView: UIView {
    public override func draw(_ rect: CGRect) {
        let leftCornerRadius: CGFloat = 20
        let midHoleRadius: CGFloat = 10
        let rightCornerRadius: CGFloat = 5
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        let topMid = CGPoint(x: rect.minX + (202 / 307) * rect.width, y: rect.minY)
        let bottomMid = CGPoint(x: rect.minX + (202 / 307) * rect.width, y: rect.maxY)
        
        path.move(to: CGPoint(x: topLeft.x + leftCornerRadius, y: topLeft.y))
        
        path.addLine(to: CGPoint(x: topMid.x - midHoleRadius, y: topMid.y))
        path.addArc(center: topMid, radius: midHoleRadius, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        path.addLine(to: CGPoint(x: topRight.x - rightCornerRadius, y: topRight.y))
        path.addArc(center: CGPoint(x: topRight.x - rightCornerRadius, y: topRight.y + rightCornerRadius), radius: rightCornerRadius, startAngle: .pi / 2, endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - rightCornerRadius))
        path.addArc(center: CGPoint(x: bottomRight.x - rightCornerRadius, y: bottomRight.y - rightCornerRadius), radius: rightCornerRadius, startAngle: 0, endAngle: .pi / 2, clockwise: false)
        path.addLine(to: CGPoint(x: bottomMid.x + midHoleRadius, y: bottomMid.y))
        path.addArc(center: bottomMid, radius: midHoleRadius, startAngle: 0, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: bottomLeft.x + leftCornerRadius, y: bottomLeft.y))
        path.addArc(center: CGPoint(x: bottomLeft.x + leftCornerRadius, y: bottomLeft.y - leftCornerRadius), radius: leftCornerRadius, startAngle: -.pi / 2, endAngle: -.pi, clockwise: false)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + leftCornerRadius))
        path.addArc(center: CGPoint(x: topLeft.x + leftCornerRadius, y: topLeft.y + leftCornerRadius), radius: leftCornerRadius, startAngle: .pi, endAngle: .pi / 2, clockwise: false)
        
        path.closeSubpath()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        self.layer.mask = maskLayer
    }
}
