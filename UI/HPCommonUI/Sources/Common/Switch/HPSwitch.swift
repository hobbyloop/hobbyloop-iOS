//
//  HPSwitch.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/09/11.
//

import UIKit

final public class HPSwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onTintColor = HPCommonUIAsset.deepOrange.color
        self.tintColor = HPCommonUIAsset.switchBackground.color
        self.backgroundColor = HPCommonUIAsset.switchBackground.color
    }
    
    public override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = frame.height / 2.0
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
