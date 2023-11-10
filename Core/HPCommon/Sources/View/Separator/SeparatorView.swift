//
//  SeparatorView.swift
//  HPCommon
//
//  Created by 김진우 on 11/10/23.
//

import UIKit

public class SeparatorView: UICollectionReusableView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
