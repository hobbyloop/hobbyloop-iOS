//
//  HPCheckbox.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/23/24.
//

import UIKit
import HPThirdParty

public final class HPCheckbox: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(HPCommonUIAsset.checkboxUnfilled.image, for: .normal)
        setImage(HPCommonUIAsset.checkboxFilled.image, for: .selected)
        self.addTarget(self, action: #selector(checkboxTapped), for: .primaryActionTriggered)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkboxTapped() {
        isSelected.toggle()
    }
}
