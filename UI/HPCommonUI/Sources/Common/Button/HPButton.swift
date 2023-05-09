//
//  HPButton.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/05/09.
//

import UIKit

import SnapKit
import Then


public final class HPButton: UIButton {
    
    private var cornerRadius: CGFloat = 10.0
    private var borderColor: CGColor?
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    
    public init(
        cornerRadius: CGFloat,
        borderColor: CGColor? = nil
        
    ) {
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        defer {
            if let borderColor {
                self.layer.borderColor = borderColor
                self.layer.borderWidth = 1.0
            }
        }

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
