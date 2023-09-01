//
//  MyPageViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/06/03.
//

import UIKit
import SnapKit
import HPCommonUI
import Then

class MyPageViewController: UIViewController {
    private let navigationTitleLabel = UILabel().then {
        $0.text = "마이페이지"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
    }
    
    private let settingsButton = UIButton().then {
        $0.setBackgroundImage(HPCommonUIAsset.settingOutlind.image, for: .normal)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    private let photoView = UIImageView().then {
        $0.layer.cornerRadius = 31
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        
        $0.snp.makeConstraints {
            $0.width.equalTo(62)
            $0.height.equalTo(62)
        }
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "지원"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private let phoneNumberLabel = UILabel().then {
        $0.text = "010-1234-5678"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
        $0.textColor = HPCommonUIAsset.infoLabel.color
    }
    
    private let userEmailLabel = UILabel().then {
        $0.text = "jiwon2@gmail.com"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
        $0.textColor = HPCommonUIAsset.infoLabel.color
    }
    
    private let editButton = UIButton().then {
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.buttonTitle.color, for: .normal)
        $0.titleLabel?.font =  HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    private lazy var reviewButton = UIButton(type: .custom).then { button in
        let imageView = UIImageView(image: HPCommonUIAsset.textOutlined.image)
        imageView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        
        let label = UILabel()
        label.attributedText = reviewCountText(5)
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        button.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(37)
            $0.height.equalTo(51)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.top)
            $0.centerX.equalTo(button.snp.centerX)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(button.snp.leading)
            $0.trailing.equalTo(button.snp.trailing)
            $0.bottom.equalTo(button.snp.bottom)
        }
    }
    
    private let pointButton = UIButton(type: .custom).then { button in
        let imageView = UIImageView(image: HPCommonUIAsset.point.image)
        imageView.snp.makeConstraints {
            $0.width.equalTo(13)
            $0.height.equalTo(19)
        }
        
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        label.text = "포인트"
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        button.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(37)
            $0.height.equalTo(51)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.top).offset(3)
            $0.centerX.equalTo(button.snp.centerX)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(button.snp.leading)
            $0.trailing.equalTo(button.snp.trailing)
            $0.bottom.equalTo(button.snp.bottom)
        }
    }
    
    private let couponButton = UIButton(type: .custom).then { button in
        let imageView = UIImageView(image: HPCommonUIAsset.bookingOutlined.image)
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints {
            $0.width.equalTo(29)
            $0.height.equalTo(28)
        }
        
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        label.text = "쿠폰"
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        button.snp.makeConstraints {
            $0.width.equalTo(37)
            $0.height.equalTo(51)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.top)
            $0.centerX.equalTo(button.snp.centerX)
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalTo(button.snp.bottom)
            $0.centerX.equalTo(button.snp.centerX)
        }
    }
    
    private let customNavigationBar = UIView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutCustomNavigationBar()
        layoutScrollView()
        layoutFirstPart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func layoutCustomNavigationBar() {
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(44)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.height.equalTo(56)
        }
        
        [navigationTitleLabel, settingsButton].forEach(customNavigationBar.addSubview(_:))
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalTo(customNavigationBar.snp.center)
        }
        
        settingsButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel.snp.centerY)
            $0.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func layoutFirstPart() {
        let userInfoLabelStack = UIStackView()
        userInfoLabelStack.axis = .vertical
        userInfoLabelStack.alignment = .leading
        userInfoLabelStack.spacing = 3
        
        [userNameLabel, phoneNumberLabel, userEmailLabel].forEach(userInfoLabelStack.addArrangedSubview(_:))
        
        [
            photoView,
            userInfoLabelStack,
            editButton
        ].forEach(scrollView.addSubview(_:))
        
        photoView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(20)
            $0.leading.equalTo(scrollView.snp.leading).offset(29)
        }
        
        userInfoLabelStack.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.top)
            $0.leading.equalTo(photoView.snp.trailing).offset(13)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(userInfoLabelStack.snp.top).offset(-3)
            $0.trailing.equalTo(view.snp.trailing).offset(-30)
        }
        
        let buttonsStack = UIStackView()
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .bottom
        buttonsStack.spacing = 57
        
        [reviewButton, pointButton, couponButton].forEach(buttonsStack.addArrangedSubview(_:))
        
        scrollView.addSubview(buttonsStack)
        
        buttonsStack.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(29)
            $0.centerX.equalTo(scrollView.snp.centerX)
        }
        
        let divierView = UIView()
        divierView.backgroundColor = HPCommonUIAsset.lightBackground.color
        
        scrollView.addSubview(divierView)
        
        divierView.snp.makeConstraints {
            $0.top.equalTo(buttonsStack.snp.bottom).offset(34)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(14)
        }
    }
    
    private func reviewCountText(_ count: Int) -> NSAttributedString {
        let newString = "리뷰 \(count)"
        let reviewRange = (newString as NSString).range(of: "리뷰 ")
        let countRange = (newString as NSString).range(of: "\(count)")
        
        let attributedString = NSMutableAttributedString(string: newString)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: reviewRange)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: countRange)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: countRange)
        
        return attributedString
    }
}
