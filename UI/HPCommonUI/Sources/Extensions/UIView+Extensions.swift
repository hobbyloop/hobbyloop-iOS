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
    
}
