//
//  HPPageControl.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/06/06.
//

import UIKit
import SnapKit

public final class HPPageControl: UIStackView {
    public var numberOfPages = 1 {
        didSet {
            if oldValue == numberOfPages {
                return
            }
            
            if oldValue < numberOfPages {
                for page in oldValue..<numberOfPages {
                    self.addArrangedSubview(generateUnselectedPageButton(to: page))
                }
            } else {
                for _ in numberOfPages..<oldValue {
                    if let lastPageButton = self.arrangedSubviews.last {
                        self.removeArrangedSubview(lastPageButton)
                    }
                }
            }
            
            currentPage = min(numberOfPages - 1, currentPage)
        }
    }
    
    public var currentPage = 0 {
        didSet {
            let pastPageButton = self.arrangedSubviews[oldValue] as! UIButton
            pastPageButton.setBackgroundImage(HPCommonUIAsset.unselectedPage.image, for: .normal)
            
            pastPageButton.snp.updateConstraints {
                $0.width.equalTo(8)
            }
            
            let currentPageButton = self.arrangedSubviews[currentPage] as! UIButton
            currentPageButton.setBackgroundImage(HPCommonUIAsset.selectedPage.image, for: .normal)
            
            currentPageButton.snp.updateConstraints {
                $0.width.equalTo(20)
            }
        }
    }
    
    weak var delegate: HPPageControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 5
        
        self.addArrangedSubview(generateSelectedPageButton(to: 0))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateUnselectedPageButton(to page: Int) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(HPCommonUIAsset.unselectedPage.image, for: .normal)
        
        button.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(8)
        }
        
        button.tag = page
        button.addTarget(self, action: #selector(movePage), for: .touchUpInside)
        
        return button
    }
    
    func generateSelectedPageButton(to page: Int) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(HPCommonUIAsset.selectedPage.image, for: .normal)
        
        button.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(8)
        }
        
        button.tag = page
        button.addTarget(self, action: #selector(movePage), for: .touchUpInside)
        
        return button
    }
    
    @objc private func movePage(_ sender: UIButton) {
        let page = sender.tag
        
        currentPage = page
        delegate?.didChangePage(to: currentPage)
    }
}
