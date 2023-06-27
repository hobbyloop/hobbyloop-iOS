//
//  FacilityInfoCollectionBottomCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/21.
//

import UIKit
import HPCommonUI
import NMapsMap

class FacilityInfoCollectionBottomCell: UICollectionViewCell {
    private lazy var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 20
        }
    }()
    
    private lazy var separator: UIView = {
        return UIView().then {
            $0.backgroundColor = .black
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.isHidden = false
            $0.snp.makeConstraints {
                $0.height.equalTo(1)
            }
        }
    }()
    
    private lazy var titleStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 11
        }
    }()
    
    private lazy var iconImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.locationOutlined.image.withRenderingMode(.alwaysOriginal)
//            $0.snp.makeConstraints {
//                $0.width.equalTo(60)
//                $0.height.equalTo(45)
//            }
        }
    }()
    
    private lazy var textLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
            $0.textColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
            $0.text = "오시는 길"
            $0.lineBreakStrategy = .hangulWordPriority
            $0.numberOfLines = 0
        }
    }()
    
//    lazy var map: UIView = {
//        return UIView(frame: CGRect(x: 0, y: 0, width: 353, height: 400)).then {
//            $0.backgroundColor = .blue
//        }
//    }()
    
    private lazy var map: NMFMapView = {
        return NMFMapView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
    }()
    
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
//        [mainStackView].forEach {
//            contentView.addSubview($0)
//        }
//
//        [titleStackView, separator, map].forEach {
//            mainStackView.addArrangedSubview($0)
//        }
//
//        [iconImageView, textLabel].forEach {
//            titleStackView.addArrangedSubview($0)
//        }
//
//        mainStackView.snp.makeConstraints {
//            $0.top.equalTo(contentView).offset(20)
//            $0.leading.trailing.bottom.equalTo(contentView)
//        }
        
        [mainStackView, separator, map].forEach {
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
            $0.leading.trailing.equalTo(contentView)
//            $0.height.equalTo(30)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
        }
        
        map.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(frame.width)
        }
    }
}
