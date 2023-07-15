//
//  TicketTemplateView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/25.
//

import UIKit

public final class EmptyTicketView: UIView {    
    public override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: 40, topRightRadius: 10, bottomLeftRadius: 40, bottomRightRadius: 10)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.systemGray.cgColor
        maskLayer.lineWidth = 0.5
        maskLayer.lineDashPattern = [10, 10]
        
        self.layer.addSublayer(maskLayer)
        // 이 방식으로 처리하면 view의 backgroundColor가 테두리 바깥에도 적용됨
        // 테두리가 점선인 ticket template view는 투명한 색으로 처리할 것이므로 문제 X
    }
}
