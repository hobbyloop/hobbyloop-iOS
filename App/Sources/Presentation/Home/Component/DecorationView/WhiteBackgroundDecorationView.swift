//
//  WhiteBackgroundDecorationView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/28.
//

import UIKit

import HPCommonUI

final class WhiteBackgroundDecorationView: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = HPCommonUIAsset.whiteColor.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
