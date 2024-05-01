//
//  UIView+Extensions.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/26.
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
    
    
    func createNoneImageTicketView(_ rect: CGRect, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        
        let maskPath = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: 35, topRightRadius: 13, bottomLeftRadius: 13, bottomRightRadius: 13)
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    func createTicketView(_ rect: CGRect, backgroundColor: UIColor, image: UIImage) -> UIView {

        let ticketView = UIView(frame: rect)
        let logoImageView = UIImageView(image: image)
        
        ticketView.backgroundColor = backgroundColor
        logoImageView.contentMode = .scaleToFill
        
        ticketView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(28)
            $0.height.equalTo(23)
            $0.center.equalToSuperview()
        }
        
        
        let maskPath = UIBezierPath(shouldRoundRect: ticketView.bounds, topLeftRadius: 10, topRightRadius: 3, bottomLeftRadius: 10, bottomRightRadius: 3)
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = maskPath.cgPath
        ticketView.layer.mask = maskLayer
        
        return ticketView
    }
    
    /// 그라데이션 경계선을 추가해주는 메서드,
    /// draw(rect:) 에서 호출할 것.
    func addGradientBorder(
        startColor: UIColor,
        endColor: UIColor,
        startPoint: CGPoint,
        endPoint: CGPoint,
        lineWidth: CGFloat,
        topLeftRadius: CGFloat,
        topRightRadius: CGFloat,
        bottomLeftRadius: CGFloat,
        bottomRightRadius: CGFloat,
        backgroundColor: UIColor? = nil
    ) {
        if let backgroundColor {
            let backgroundLayer = CALayer()
            backgroundLayer.frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
            let backgroundShape = CAShapeLayer()
            backgroundShape.lineWidth = 0
            backgroundShape.path = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius, width: 0).cgPath
            
            backgroundShape.strokeColor = UIColor.clear.cgColor
            backgroundShape.fillColor = UIColor.gray.cgColor
            backgroundLayer.mask = backgroundShape
            backgroundLayer.backgroundColor = backgroundColor.cgColor
            
            self.layer.insertSublayer(backgroundLayer, at: 0)
        }
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        let startColor = startColor
        let endColor = endColor
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius, width: lineWidth).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
}
