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
    // MARK: - navigation bar
    private let customNavigationBar = UIView()
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
    
    // MARK: - scroll view
    private let scrollView = UIScrollView()
    
    // MARK: - 유저 정보 파트 UI
    private let userInfoPartView = UIView()
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
        $0.textColor = HPCommonUIAsset.userInfoLabel.color
    }
    
    private let userEmailLabel = UILabel().then {
        $0.text = "jiwon2@gmail.com"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
        $0.textColor = HPCommonUIAsset.userInfoLabel.color
    }
    
    private let editButton = UIButton().then {
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.buttonTitle.color, for: .normal)
        $0.titleLabel?.font =  HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
    }
    
    private lazy var reviewButton = verticalStackButton(
        imageView: UIImageView(image: HPCommonUIAsset.textOutlined.image).then {
            $0.snp.makeConstraints {
                $0.width.equalTo(32)
                $0.height.equalTo(32)
            }
        },
        label: UILabel().then {
            $0.attributedText = reviewCountText(5)
        }
    )
    
    private lazy var pointButton = verticalStackButton(
        imageView: UIImageView(image: HPCommonUIAsset.point.image).then {
            $0.snp.makeConstraints {
                $0.width.equalTo(13)
                $0.height.equalTo(19)
            }
        },
        label: UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
            $0.text = "포인트"
        },
        topMargin: 3
    )
    
    private lazy var couponButton = verticalStackButton(
        imageView: UIImageView(image: HPCommonUIAsset.bookingOutlined.image).then {
            $0.contentMode = .scaleToFill
            $0.snp.makeConstraints {
                $0.width.equalTo(29)
                $0.height.equalTo(28)
            }
        },
        label: UILabel().then {
            $0.textAlignment = .center
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
            $0.text = "쿠폰"
        }
    )
    
    // MARK: - 이용권 파트 UI
    private let couponPartView = UIView()
    private lazy var couponPartHeaderButton = partHeaderButton(text: "내 이용권")
    
    private let couponListView = CouponListView(coupons: [
        .init(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
        .init(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
    ], withPageControl: false)
    
    private let classCountLabel = UILabel().then {
        $0.text = "13"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.deepOrange.color
    }
    
    private lazy var reservableClassButton = horizontalStackButton(
        imageView: UIImageView(image: HPCommonUIAsset.calendarOutlined.image).then({
            $0.snp.makeConstraints {
                $0.width.equalTo(24)
                $0.height.equalTo(24)
            }
        }),
        description: "예약가능 수업",
        countLabel: classCountLabel
    )
    
    private let couponCountLabel = UILabel().then {
        $0.text = "8"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.deepOrange.color
    }
    
    private lazy var remainingCouponButton = horizontalStackButton(
        imageView: UIImageView(image: HPCommonUIAsset.ticket.image).then({
            $0.snp.makeConstraints {
                $0.width.equalTo(18.89)
                $0.height.equalTo(13.93)
            }
        }),
        description: "이용권 잔여",
        countLabel: couponCountLabel
    )
    
    // MARK: - 수업 내역 파트 UI
    private lazy var classPartHeaderButton = partHeaderButton(text: "수업 내역")
    private let instructorPhotoView = UIImageView().then {
        $0.layer.cornerRadius = 31
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        
        $0.snp.makeConstraints {
            $0.width.equalTo(62)
            $0.height.equalTo(62)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        layoutCustomNavigationBar()
        layoutScrollView()
        layoutUserInfoPartView()
        layoutCouponPartView()
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
    
    // MARK: - 구분선 기준으로 파트 구분
    // MARK: - 유저 정보 파트 레이아웃
    private func layoutUserInfoPartView() {
        let userInfoLabelStack = UIStackView()
        userInfoLabelStack.axis = .vertical
        userInfoLabelStack.alignment = .leading
        userInfoLabelStack.spacing = 3
        
        [userNameLabel, phoneNumberLabel, userEmailLabel].forEach(userInfoLabelStack.addArrangedSubview(_:))
        
        [photoView, userInfoLabelStack, editButton].forEach(userInfoPartView.addSubview(_:))
        
        photoView.snp.makeConstraints {
            $0.top.equalTo(userInfoPartView.snp.top).offset(20)
            $0.leading.equalTo(userInfoPartView.snp.leading).offset(29)
        }
        
        userInfoLabelStack.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.top)
            $0.leading.equalTo(photoView.snp.trailing).offset(13)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(userInfoLabelStack.snp.top).offset(-3)
            $0.trailing.equalTo(userInfoPartView.snp.trailing).offset(-30)
        }
        
        let buttonsStack = UIStackView()
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .bottom
        buttonsStack.spacing = 57
        
        [reviewButton, pointButton, couponButton].forEach(buttonsStack.addArrangedSubview(_:))
        
        userInfoPartView.addSubview(buttonsStack)
        
        buttonsStack.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(29)
            $0.centerX.equalTo(userInfoPartView.snp.centerX)
        }
        
        let divierView = UIView()
        divierView.backgroundColor = HPCommonUIAsset.lightBackground.color
        
        userInfoPartView.addSubview(divierView)
        
        divierView.snp.makeConstraints {
            $0.top.equalTo(buttonsStack.snp.bottom).offset(34)
            $0.leading.equalTo(userInfoPartView.snp.leading)
            $0.width.equalTo(userInfoPartView.snp.width)
            $0.height.equalTo(14)
            $0.bottom.equalTo(userInfoPartView.snp.bottom)
        }
        
        scrollView.addSubview(userInfoPartView)
        userInfoPartView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.width.equalTo(scrollView.snp.width)
        }
    }
    
    // MARK: - 이용권 파트 레이아웃
    private func layoutCouponPartView() {
        [couponPartHeaderButton, couponListView].forEach(couponPartView.addSubview(_:))
        
        couponPartHeaderButton.snp.makeConstraints {
            $0.top.equalTo(couponPartView.snp.top).offset(28)
            $0.leading.equalTo(couponPartView.snp.leading)
            $0.trailing.equalTo(couponPartView.snp.trailing)
        }
        
        couponListView.snp.makeConstraints {
            $0.top.equalTo(couponPartHeaderButton.snp.bottom).offset(25)
            $0.leading.equalTo(couponPartView.snp.leading)
            $0.trailing.equalTo(couponPartView.snp.trailing)
            $0.height.equalTo(170)
        }
        
        let buttonDivider = UIView()
        buttonDivider.backgroundColor = HPCommonUIAsset.separator.color
        buttonDivider.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(23)
        }
        
        [reservableClassButton, buttonDivider, remainingCouponButton].forEach(couponPartView.addSubview(_:))
        
        buttonDivider.snp.makeConstraints {
            $0.centerX.equalTo(couponPartView.snp.centerX).offset(10)
            $0.top.equalTo(couponListView.snp.bottom).offset(26)
        }
        
        reservableClassButton.snp.makeConstraints {
            $0.trailing.equalTo(buttonDivider.snp.leading).offset(-26)
            $0.centerY.equalTo(buttonDivider.snp.centerY)
        }
        
        remainingCouponButton.snp.makeConstraints {
            $0.leading.equalTo(buttonDivider.snp.trailing).offset(29)
            $0.centerY.equalTo(buttonDivider.snp.centerY)
        }
        
        let divierView = UIView()
        divierView.backgroundColor = HPCommonUIAsset.lightBackground.color
        
        couponPartView.addSubview(divierView)
        
        divierView.snp.makeConstraints {
            $0.top.equalTo(buttonDivider.snp.bottom).offset(24)
            $0.leading.equalTo(couponPartView.snp.leading)
            $0.width.equalTo(couponPartView.snp.width)
            $0.height.equalTo(14)
            $0.bottom.equalTo(couponPartView.snp.bottom)
        }
        
        scrollView.addSubview(couponPartView)
        couponPartView.snp.makeConstraints {
            $0.top.equalTo(userInfoPartView.snp.bottom)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.width.equalTo(scrollView.snp.width)
        }
    }
}