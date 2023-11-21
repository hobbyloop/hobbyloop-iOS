//
//  TicketTemplateView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/25.
//

import UIKit
import SnapKit
import Then

public final class EmptyTicketView: UIView {
    let topLeftRadius: CGFloat
    let topRightRadius: CGFloat
    let bottomLeftRadius: CGFloat
    let bottomRightRadius: CGFloat
    
    public init(topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        self.topLeftRadius = topLeftRadius
        self.topRightRadius = topRightRadius
        self.bottomLeftRadius = bottomLeftRadius
        self.bottomRightRadius = bottomRightRadius
        
        super.init(frame: .infinite)
        
        let logoImage = HPCommonUIAsset.logo.image
        let logoImageView = UIImageView(image: logoImage)
        
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(33.58)
            $0.height.equalTo(23.7)
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).offset(-51.42)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = HPCommonUIAsset.gray3.color.cgColor
        maskLayer.lineWidth = 0.5
        maskLayer.lineDashPattern = [10, 10]
        
        self.layer.addSublayer(maskLayer)
        // 이 방식으로 처리하면 view의 backgroundColor가 테두리 바깥에도 적용됨
        // 테두리가 점선인 ticket template view는 투명한 색으로 처리할 것이므로 문제 X
        
        let midLineLayer = CAShapeLayer()
        midLineLayer.strokeColor = HPCommonUIAsset.gray3.color.cgColor
        midLineLayer.lineWidth = 0.5
        midLineLayer.lineDashPattern = [10, 10]
        let cgPath = CGMutablePath()
        let cgPoints = [CGPoint(x: self.frame.width - 136.42, y: 0), CGPoint(x: self.frame.width - 136.42, y: self.frame.height)]
        cgPath.addLines(between: cgPoints)
        midLineLayer.path = cgPath
        layer.addSublayer(midLineLayer)
        
    }
}
