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
    
    /// corner: [leftTop, rightTop, rightBottom, leftBottom]
    /// width: Gradient Width
    func addGradientCornerRadius(_ gradientWidth: CGFloat, _ corner: [CGFloat], gradientColor: [CGColor], gradientLocation: [NSNumber]) {
        // MARK: - Gradient Layer 완성
        // 무지개 색을 위한 CAGradientLayer 생성
        let gradientLayer = CAGradientLayer()
        let radius: CGFloat = self.bounds.width * 1.1
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        // 하비루프 색상
        gradientLayer.locations = gradientLocation
        gradientLayer.colors = gradientColor
        
        
        gradientLayer.frame = CGRect(origin: CGPoint(x: -((radius / 2) - (self.bounds.width / 2)), y: -((radius / 2) - (self.bounds.height / 2))), size: CGSize(width: radius, height: radius))
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius, height: radius), cornerRadius: radius / 2).cgPath
        gradientLayer.mask = circleLayer
        
        // 무지개 색이 회전하는 애니메이션 추가
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber(value: Double.pi * 2)
        animation.duration = 4 // 5초 동안 한 바퀴 회전
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "rotationAnimation")
        // Gradient Layer 완성
        
        // MARK: - Round Layer 완성
        
        let bounds_item = self.bounds
        let cgPath = UIBezierPath()
        let path = CGMutablePath()
        let leftTop: CGPoint = bounds_item.origin
        let rightTop: CGPoint = CGPoint(x: bounds_item.maxX, y: bounds_item.minY)
        let leftBottom: CGPoint = CGPoint(x: bounds_item.minX, y: bounds_item.maxY)
        let rightBottom: CGPoint = CGPoint(x: bounds_item.maxX, y: bounds_item.maxY)
        
        // 시작 지점 (왼쪽 위)
        path.move(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y))
        
        // 왼쪽 위 모서리로 선을 그리고, 왼쪽 위 모서리에 대해 둥근 모서리를 그립니다.
        path.addLine(to: CGPoint(x: rightTop.x - corner[1], y: rightTop.y))
        path.addCurve(to: CGPoint(x: rightTop.x, y: rightTop.y + corner[1]),
                      control1: CGPoint(x: rightTop.x, y: rightTop.y),
                      control2: CGPoint(x: rightTop.x, y: rightTop.y + corner[1]))
        
        // 오른쪽 아래
        path.addLine(to: CGPoint(x: rightBottom.x, y: rightBottom.y - corner[2]))
        path.addCurve(to: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y),
                      control1: CGPoint(x: rightBottom.x, y: rightBottom.y),
                      control2: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y))
        
        // 왼쪽 아래
        path.addLine(to: CGPoint(x: leftBottom.x + corner[3], y: leftBottom.y))
        path.addCurve(to: CGPoint(x: leftBottom.x, y: leftBottom.y - corner[3]),
                      control1: CGPoint(x: leftBottom.x, y: leftBottom.y),
                      control2: CGPoint(x: leftBottom.x, y: leftBottom.y - corner[3]))
        
        // 왼쪽 위
        path.addLine(to: CGPoint(x: leftTop.x, y: leftTop.y + corner[0]))
        path.addCurve(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y),
                      control1: CGPoint(x: leftTop.x, y: leftTop.y),
                      control2: CGPoint(x: leftTop.x + corner[0], y: leftTop.y))
        
        path.closeSubpath()
        cgPath.cgPath = path
        
        
        // MARK: - Round Layer2 완성
        /// 아래 Layer는 넓이 만큼 백그라운드 색상을 표시함
        let testPath = UIBezierPath()
        let borderPath = CGMutablePath()
        
        // 시작 지점 (왼쪽 위)
        borderPath.move(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y + gradientWidth))
        
        // 왼쪽 위 모서리로 선을 그리고, 왼쪽 위 모서리에 대해 둥근 모서리를 그립니다.
        borderPath.addLine(to: CGPoint(x: rightTop.x - corner[1], y: rightTop.y + gradientWidth))
        borderPath.addCurve(to: CGPoint(x: rightTop.x - gradientWidth, y: rightTop.y + corner[1]),
                      control1: CGPoint(x: rightTop.x - gradientWidth, y: rightTop.y + gradientWidth),
                      control2: CGPoint(x: rightTop.x - gradientWidth, y: rightTop.y + corner[1]))
        
        // 오른쪽 아래
        borderPath.addLine(to: CGPoint(x: rightBottom.x - gradientWidth, y: rightBottom.y - corner[2]))
        borderPath.addCurve(to: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y - gradientWidth),
                      control1: CGPoint(x: rightBottom.x - gradientWidth, y: rightBottom.y - gradientWidth),
                      control2: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y - gradientWidth))
        
        // 왼쪽 아래
        borderPath.addLine(to: CGPoint(x: leftBottom.x + corner[3], y: leftBottom.y - gradientWidth))
        borderPath.addCurve(to: CGPoint(x: leftBottom.x + gradientWidth, y: leftBottom.y - corner[3]),
                      control1: CGPoint(x: leftBottom.x + gradientWidth, y: leftBottom.y - gradientWidth),
                      control2: CGPoint(x: leftBottom.x + gradientWidth, y: leftBottom.y - corner[3]))
        
        // 왼쪽 위
        borderPath.addLine(to: CGPoint(x: leftTop.x + gradientWidth, y: leftTop.y + corner[0]))
        borderPath.addCurve(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y + gradientWidth),
                      control1: CGPoint(x: leftTop.x + gradientWidth, y: leftTop.y + gradientWidth),
                      control2: CGPoint(x: leftTop.x + corner[0], y: leftTop.y + gradientWidth))
        
        borderPath.closeSubpath()
        testPath.cgPath = borderPath
        
        
        let shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = cgPath.cgPath
        
        let shape2 = CAShapeLayer()
        shape2.frame = self.bounds
        shape2.path = testPath.cgPath
        shape2.fillColor = UIColor.white.cgColor
        
        self.layer.mask = shape
        self.layer.addSublayer(gradientLayer)
        self.layer.addSublayer(shape2)
    }
    
    /// corner: [leftTop, rightTop, rightBottom, leftBottom]
    /// width: Gradient Width
    func customCornerRadius(_ corner: [CGFloat]) {
        let bounds_item = self.bounds
        let cgPath = UIBezierPath()
        let path = CGMutablePath()
        let leftTop: CGPoint = bounds_item.origin
        let rightTop: CGPoint = CGPoint(x: bounds_item.maxX, y: bounds_item.minY)
        let leftBottom: CGPoint = CGPoint(x: bounds_item.minX, y: bounds_item.maxY)
        let rightBottom: CGPoint = CGPoint(x: bounds_item.maxX, y: bounds_item.maxY)
        
        // 시작 지점 (왼쪽 위)
        path.move(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y))
        
        // 왼쪽 위 모서리로 선을 그리고, 왼쪽 위 모서리에 대해 둥근 모서리를 그립니다.
        path.addLine(to: CGPoint(x: rightTop.x - corner[1], y: rightTop.y))
        path.addCurve(to: CGPoint(x: rightTop.x, y: rightTop.y + corner[1]),
                      control1: CGPoint(x: rightTop.x, y: rightTop.y),
                      control2: CGPoint(x: rightTop.x, y: rightTop.y + corner[1]))
        
        // 오른쪽 아래
        path.addLine(to: CGPoint(x: rightBottom.x, y: rightBottom.y - corner[2]))
        path.addCurve(to: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y),
                      control1: CGPoint(x: rightBottom.x, y: rightBottom.y),
                      control2: CGPoint(x: rightBottom.x - corner[2], y: rightBottom.y))
        
        // 왼쪽 아래
        path.addLine(to: CGPoint(x: leftBottom.x + corner[3], y: leftBottom.y))
        path.addCurve(to: CGPoint(x: leftBottom.x, y: leftBottom.y - corner[3]),
                      control1: CGPoint(x: leftBottom.x, y: leftBottom.y),
                      control2: CGPoint(x: leftBottom.x, y: leftBottom.y - corner[3]))
        
        // 왼쪽 위
        path.addLine(to: CGPoint(x: leftTop.x, y: leftTop.y + corner[0]))
        path.addCurve(to: CGPoint(x: leftTop.x + corner[0], y: leftTop.y),
                      control1: CGPoint(x: leftTop.x, y: leftTop.y),
                      control2: CGPoint(x: leftTop.x + corner[0], y: leftTop.y))
        
        path.closeSubpath()
        cgPath.cgPath = path
        
        let shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = cgPath.cgPath
        
        self.layer.mask = shape
    }

}
