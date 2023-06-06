//
//  HPPageControl.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/06.
//

import UIKit

class HPPageControl: UIPageControl {
    override var currentPage: Int {
        didSet {
            for i in 0..<self.numberOfPages {
                self.setIndicatorImage(HPCommonUIAsset.unselectedPage.image, forPage: i)
            }
            self.setIndicatorImage(HPCommonUIAsset.selectedPage.image, forPage: currentPage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.preferredIndicatorImage = HPCommonUIAsset.unselectedPage.image
        self.pageIndicatorTintColor = HPCommonUIAsset.deepSeparator.color
        self.currentPageIndicatorTintColor = HPCommonUIAsset.deepOrange.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
