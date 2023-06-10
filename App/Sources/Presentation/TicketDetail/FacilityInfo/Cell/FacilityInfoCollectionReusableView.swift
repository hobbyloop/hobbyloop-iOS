//
//  FacilityInfoCollectionReusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/08.
//

import UIKit

import HPCommonUI

class FacilityInfoCollectionReusableView: UICollectionReusableView {
    private var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.distribution = .fillProportionally
            $0.spacing = 13
        }
    }()
    
    private var centerImageView: UIImageView = {
        return UIImageView()
    }()
    
    private var middleView: UIView = {
        return UIView()
    }()
    
    private var hyperlinkStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 3
            $0.alignment = .center
            $0.distribution = .fill
        }
    }()
    
    private var centerIconImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.centerOutlined.image.withRenderingMode(.alwaysOriginal)
            $0.snp.makeConstraints {
                $0.width.height.equalTo(24)
            }
        }
    }()
    
    private var centerHyperButton: UIButton = {
        return UIButton().then {
            let text = "업체 상세페이지 바로가기"
            let attributedString = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: text)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.light.font(size: 12), range: range)
            attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0, green: 0, blue: 0, alpha: 1), range: range)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
        }
    }()
    
    private var communicationStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 15
        }
    }()
    
    private var callButton: UIButton = {
        return UIButton().then {
            $0.setImage(HPCommonUIAsset.callOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }()
    
    private var messageButton: UIButton = {
        return UIButton().then {
            $0.setImage(HPCommonUIAsset.textOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }()
    
    private var titleStackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 9
            $0.axis = .vertical
            $0.alignment = .leading
        }
    }()
    
    private var titleLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 18)
        }
    }()
    
    private var descriptionLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }()
    
    private var starStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
        }
    }()
    
    private var starView: UIView = {
        return UIView()
    }()
    
    private var starImageView: UIImageView = {
        return UIImageView().then {
            $0.tintColor = .yellow
            $0.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    private var starLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }()
    
    private var starArrowImageView: UIImageView = {
        return UIImageView().then {
            $0.tintColor = .black
            $0.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(mainStackView)
        
        [centerImageView, middleView, titleStackView, starStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [hyperlinkStackView, communicationStackView].forEach {
            middleView.addSubview($0)
        }
        
        hyperlinkStackView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        communicationStackView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        [centerIconImageView, centerHyperButton].forEach {
            hyperlinkStackView.addArrangedSubview($0)
        }
        
        [callButton, messageButton].forEach {
            communicationStackView.addArrangedSubview($0)
        }
        
        [titleLabel, descriptionLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [starView, UIView()].forEach {
            starStackView.addArrangedSubview($0)
        }
        
        [starImageView, starLabel, starArrowImageView].forEach {
            starView.addSubview($0)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(13)
            $0.centerY.equalToSuperview()
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.top.bottom.equalToSuperview()
        }
        
        starArrowImageView.snp.makeConstraints {
            $0.leading.equalTo(starLabel.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        centerImageView.snp.makeConstraints {
            $0.height.equalTo(236)
        }
        
    }
    
    public func configure() {
        var text = "4.8"
        centerImageView.image = UIImage(named: "TicketTestImage")?.withRenderingMode(.alwaysOriginal)
        titleLabel.text = "발란스 스튜디오"
        descriptionLabel.text = "서울 강남구 압구정로50길 8 2층"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.regular.font(size: 12), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1), range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        starLabel.attributedText = attributedString
    }
}
