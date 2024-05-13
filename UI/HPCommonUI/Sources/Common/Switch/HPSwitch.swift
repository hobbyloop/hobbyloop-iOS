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
        self.onTintColor = HPCommonUIAsset.primary.color
        self.backgroundColor = HPCommonUIAsset.switchBackground.color
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
