//
//  SystemBackgroundDecorationView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/28.
//

import UIKit

import HPCommonUI


final class SystemBackgroundDecorationView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = HPCommonUIAsset.backgroundColor.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
