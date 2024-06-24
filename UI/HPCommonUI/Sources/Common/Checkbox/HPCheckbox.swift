//
//  HPCheckbox.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/23/24.
//

import UIKit
import SnapKit

public final class HPCheckbox: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(HPCommonUIAsset.checkboxUnfilled.image, for: .normal)
        self.setImage(HPCommonUIAsset.checkboxFilled.image, for: .selected)
        self.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
