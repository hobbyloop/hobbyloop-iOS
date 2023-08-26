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
        let imageView = UIImageView(image: HPCommonUIAsset.settingOutlind.image)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
        $0.addSubview(imageView)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.center.equalTo(imageView.snp.center)
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
        $0.titleLabel?.text = "수정하기"
        $0.titleLabel?.font =  HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    private lazy var reviewButton = UIButton().then {
        let imageView = UIImageView(image: HPCommonUIAsset.textOutlined.image)
        imageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(21.33)
        }
        
        let label = UILabel()
        label.attributedText = reviewCountText(5)
        
        $0.addSubview(imageView)
        $0.addSubview(label)
        
        $0.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top).offset(-5.335)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.leading.equalTo(label.snp.leading)
            $0.trailing.equalTo(label.snp.trailing)
            $0.bottom.equalTo(label.snp.bottom)
            $0.height.equalTo(51)
        }
    }
    
    private let pointButton = UIButton().then {
        let imageView = UIImageView(image: HPCommonUIAsset.point.image)
        imageView.snp.makeConstraints {
            $0.width.equalTo(13)
            $0.height.equalTo(19)
        }
        
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        label.text = "포인트"
        
        $0.addSubview(imageView)
        $0.addSubview(label)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(37)
            $0.height.equalTo(50)
            $0.top.equalTo(imageView.snp.top).offset(-2)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.leading.equalTo(label.snp.leading)
            $0.trailing.equalTo(label.snp.trailing)
            $0.bottom.equalTo(label.snp.bottom)
        }
    }
    
    private let couponButton = UIButton().then {
        let imageView = UIImageView(image: HPCommonUIAsset.bookingOutlined.image)
        imageView.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(16)
        }
        
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        label.text = "쿠폰"
        
        $0.addSubview(imageView)
        $0.addSubview(label)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(37)
            $0.height.equalTo(50)
            $0.top.equalTo(imageView.snp.top).offset(-4)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.leading.equalTo(label.snp.leading).offset(-6)
            $0.trailing.equalTo(label.snp.trailing).offset(6)
            $0.bottom.equalTo(label.snp.bottom)
        }
    }
    
    private let customNavigationBar = UIView()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutCustomNavigationBar()
        layoutScrollView()
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
