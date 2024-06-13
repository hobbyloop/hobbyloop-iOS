//
//  EventResusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 6/7/24.
//

import UIKit

import HPCommonUI

class EventResusableView: UICollectionReusableView {
    
    private let eventCotentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .brown
    }
    
    private let eventPageCountView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.black.color.withAlphaComponent(0.5)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let eventPageCountLable: UILabel = UILabel().then {
        $0.text = "0 / 0"
        $0.textColor = HPCommonUIAsset.white.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textAlignment = .center
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        eventPageCountView.addSubview(eventPageCountLable)
        
        [eventCotentImageView, eventPageCountView].forEach {
            self.addSubview($0)
        }
        
        eventCotentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        eventPageCountView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        
        eventPageCountLable.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        
    }
}
