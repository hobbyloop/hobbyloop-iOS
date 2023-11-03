//
//  TicketSelectReusableView.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/15.
//

import UIKit

import HPCommonUI

public final class TicketSelectReusableView: UITableViewHeaderFooterView {
    
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = HPCommonUIAsset.systemBackground.color
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
