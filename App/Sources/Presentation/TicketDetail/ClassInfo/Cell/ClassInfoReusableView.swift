//
//  ClassInfoReusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/21.
//

import UIKit

import HPCommonUI
import HPCommon

class ClassInfoReusableView: UICollectionReusableView {
    private lazy var mainStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 29
            $0.alignment = .fill
        }
    }()
    
    private lazy var couponListView: CouponListView = {
        return CouponListView(coupons: [DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
                                        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
                                        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date()),
                                        DummyCoupon(companyName: "발란스 스튜디오", count: 10, start: Date(), end: Date())])
    }()
    
    private lazy var titleStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 19
            $0.alignment = .leading
        }
    }()
    
    private lazy var titleView: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.text = "6:1 그룹레슨 10회 이용권"
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
        }
    }()
    
    private lazy var review: StarReviewView = {
        return StarReviewView()
    }()
    
    private lazy var discountCouponStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 5
        }
    }()
    
    private lazy var discountImage: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.coupon.image.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    private lazy var discountLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var discountDownImage: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.downMark.image.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    private lazy var priceStackView: UIStackView = {
        return UIStackView().then {
            $0.alignment = .leading
            $0.spacing = 4
            $0.axis = .vertical
        }
    }()
    
    private lazy var priceLabel: UILabel = {
        return UILabel().then {
            let fullText = "예상 구매가 *"
            let range = (fullText as NSString).range(of: "*")
            let fullRange = (fullText as NSString).range(of: fullText)
            let attributedString = NSMutableAttributedString(string: fullText)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 16), range: fullRange)
            attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: range)
            $0.attributedText = attributedString
        }
    }()
    
    private lazy var saleStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 10
        }
    }()
    
    private lazy var saleBeforeLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
            $0.textColor = HPCommonUIAsset.lightSeparator.color
        }
    }()
    
    private lazy var saleAfterLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
            $0.textColor = HPCommonUIAsset.deepOrange.color
        }
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        backgroundColor = .white
        [couponListView, mainStackView].forEach {
            addSubview($0)
        }
        
        [titleStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [titleView, discountCouponStackView, priceStackView].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [titleLabel, review].forEach {
            titleView.addSubview($0)
        }
        
        titleView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        [discountImage, discountLabel, discountDownImage].forEach {
            discountCouponStackView.addArrangedSubview($0)
        }
        
        [priceLabel, saleStackView].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        [saleBeforeLabel, saleAfterLabel].forEach {
            saleStackView.addArrangedSubview($0)
        }
        
        couponListView.snp.makeConstraints {
            $0.height.equalTo(209)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(couponListView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(29)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(review.snp.leading)
        }
        
        review.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(110)
        }
        
    }
    
    public func configure(_ num: Int) {
        review.configure(num)
        let fullText = "최대 5000원 쿠폰받기"
        let range = NSRange(location: 3, length: 5)
        let fullRange = (fullText as NSString).range(of: fullText)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: range)
        discountLabel.attributedText = attributedString
        
        saleBeforeLabel.text = "200,000원"
        saleAfterLabel.text = "191,000원"
    }
}
