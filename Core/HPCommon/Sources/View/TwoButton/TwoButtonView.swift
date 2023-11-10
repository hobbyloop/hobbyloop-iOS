//
//  TwoButtonView.swift
//  HPCommon
//
//  Created by 김진우 on 10/22/23.
//

import UIKit

import HPCommonUI
import HPThirdParty
import RxSwift

public class TwoButtonView: UIView {
    private lazy var backyardView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
        addSubview($0)
    }
    
    private lazy var mainView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        backyardView.addSubview($0)
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
    }
    
    private lazy var subscribeLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    public lazy var leftButton = UIButton().then {
        $0.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        $0.layer.cornerRadius = 8
    }
    
    public lazy var rightButton = UIButton().then {
        $0.backgroundColor = HPCommonUIAsset.deepOrange.color
        $0.layer.cornerRadius = 8
    }
    
    /// note: 백그라운드 뷰가 반투명의 검은색이고, 하단에 버튼이 두개가 있으며 사용자에게 의견을 묻는 뷰이다.
    ///     각 버튼의 액션의 경우 leftButton, rightButton의 .rx.tap 을 Bind 하여 사용
    /// Parameter:
    ///             `title`:                     최 상단의 Bold 처리되어 있는 뷰의 텍스트
    ///             `subscribe`:            TitleView의 하단에 있는 설명에 관련된 뷰의 텍스트
    ///             `image`:                     최 상단의 이미지 뷰의 이미지
    ///             `leftButton_St`:   왼쪽 버튼의 텍스트
    ///             `rightButton_st`: 오른쪽 버튼의 텍스트
    ///  
    public func configure(title: String, subscribe: String, image: UIImage, leftButton_St: String, rightButton_St: String) {
        imageView.image = image
        titleLabel.text = title
        subscribeLabel.text = subscribe
//        HPCommonUIAsset.settingOutlind.image
//            .withTintColor(HPCommonUIAsset.deepOrange.color)
//            .imageWith(newSize: CGSize(width: 44, height: 44))
        
        let afterString = leftButton_St.stringToAttributed(
            HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
            HPCommonUIAsset.lightblack.color
        )
        leftButton.setAttributedTitle(afterString, for: .normal)
        
        let settingString = rightButton_St.stringToAttributed(
            HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
            .white
        )
        rightButton.setAttributedTitle(settingString, for: .normal)
        
        
        
        [imageView, titleLabel, subscribeLabel, buttonStackView].forEach {
            mainView.addSubview($0)
        }
        
        [leftButton, rightButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        backyardView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(335)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
        subscribeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subscribeLabel.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(322)
            $0.height.equalTo(59)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
