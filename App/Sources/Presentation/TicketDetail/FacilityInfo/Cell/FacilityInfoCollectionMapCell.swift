//
//  FacilityInfoCollectionMapCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/21.
//

import UIKit
import HPCommonUI
import NMapsMap

class FacilityInfoCollectionMapCell: UICollectionViewCell {
    private lazy var mainStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 20
    }
    
    private lazy var titleStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 11
    }
    
    private lazy var iconImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.locationFilled.image.withRenderingMode(.alwaysOriginal)
    }
    
    private lazy var textLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        $0.text = "오시는 길"
        $0.lineBreakStrategy = .hangulWordPriority
        $0.numberOfLines = 0
    }
    
    private lazy var map: NMFMapView = NMFMapView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.preferredMaxLayoutWidth = textLabel.frame.size.width
        super.layoutSubviews()
    }
    
    private func initLayout() {
        backgroundColor = .white
        
        [mainStackView, map].forEach {
            contentView.addSubview($0)
        }
        
        [titleStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [iconImageView, textLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.trailing.equalTo(contentView)
            $0.leading.equalToSuperview().offset(16)
        }
        
        map.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(frame.width)
        }
    }
}
