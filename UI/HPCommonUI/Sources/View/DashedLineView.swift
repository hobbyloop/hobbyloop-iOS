//
//  DashedLineView.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/30/24.
//

import UIKit

/// 점선을 그려주는 view
public final class DashedLineView: UIView {
    public enum Axis {
        case horizontal
        case vertical
    }
    
    let axis: Axis
    let dashLength: NSNumber
    let dashGap: NSNumber
    let color: UIColor
    
    public init(axis: Axis, dashLength: NSNumber, dashGap: NSNumber, color: UIColor) {
        self.axis = axis
        self.dashLength = dashLength
        self.dashGap = dashGap
        self.color = color
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = axis == .horizontal ? rect.size.height : rect.size.width
        shapeLayer.lineDashPattern = [dashLength, dashGap]
        
        let path = CGMutablePath()
        let startPoint = axis == .horizontal ? CGPoint(x: 0, y: rect.height / 2) : CGPoint(x: rect.width / 2, y: 0)
        let endPoint = axis == .horizontal ? CGPoint(x: rect.width, y: rect.height / 2) : CGPoint(x: rect.width / 2, y: rect.height)
        
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
