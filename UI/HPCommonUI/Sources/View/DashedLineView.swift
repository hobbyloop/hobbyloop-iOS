//
//  DashedLineView.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/30/24.
//

import UIKit

public class DashedView: UIView {
    
    public struct Configuration {
        public var color: UIColor
        public var dashLength: CGFloat
        public var dashGap: CGFloat
        
        public init(
            color: UIColor,
            dashLength: CGFloat,
            dashGap: CGFloat) {
                self.color = color
                self.dashLength = dashLength
                self.dashGap = dashGap
            }
        
        static let `default`: Self = .init(
            color: .lightGray,
            dashLength: 7,
            dashGap: 3)
    }
    
    // MARK: - Properties
    
    /// Override to customize height
    public class var lineHeight: CGFloat { 1.0 }
    
    override public var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Self.lineHeight)
    }
    
    public final var config: Configuration = .default {
        didSet {
            drawDottedLine()
        }
    }
    
    private var dashedLayer: CAShapeLayer?
    
    // MARK: - Life Cycle
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // We only redraw the dashes if the width has changed.
        guard bounds.width != dashedLayer?.frame.width else { return }
        
        drawDottedLine()
    }
    
    // MARK: - Drawing
    
    private func drawDottedLine() {
        if dashedLayer != nil {
            dashedLayer?.removeFromSuperlayer()
        }
        
        dashedLayer = drawDottedLine(
            start: bounds.origin,
            end: CGPoint(x: bounds.width, y: bounds.origin.y),
            config: config)
    }
    
}

// Thanks to: https://stackoverflow.com/a/49305154/4802021
private extension DashedView {
    func drawDottedLine(
        start: CGPoint,
        end: CGPoint,
        config: Configuration) -> CAShapeLayer {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = config.color.cgColor
            shapeLayer.lineWidth = Self.lineHeight
            shapeLayer.lineDashPattern = [config.dashLength as NSNumber, config.dashGap as NSNumber]
            
            let path = CGMutablePath()
            path.addLines(between: [start, end])
            shapeLayer.path = path
            layer.addSublayer(shapeLayer)
            
            return shapeLayer
        }
}
