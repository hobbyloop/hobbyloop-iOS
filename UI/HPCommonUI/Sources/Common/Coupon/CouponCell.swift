//
//  CouponView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/05/30.
//

import UIKit

import SnapKit
import Then

public final class CouponCell: UICollectionViewCell {
    public static let identifier = "CouponCell"
    
    private let backgroundImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.oneMonthCoupon.image
    }
    
    private let logoImageView = UIImageView().then {
        $0.sizeToFit()
        $0.snp.makeConstraints {
            $0.width.equalTo(52)
            $0.height.equalTo(52)
        }
    }
    public var logoImage: UIImage? {
        get { logoImageView.image }
        set { logoImageView.image = newValue }
    }
    
    private let studioNameLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    public var studioName: String? {
        get { studioNameLabel.text }
        set { studioNameLabel.text = newValue }
    }
    
    private let couponNameLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    public var couponName: String? {
        get { couponNameLabel.text }
        set { couponNameLabel.text = newValue }
    }
    
    private let countLabel = UILabel()
    public var count: Int = 0 {
        didSet {
            updateCountLabel(to: count, maxCount: maxCount, duration: duration)
        }
    }
    public var maxCount: Int = 0 {
        didSet {
            updateCountLabel(to: count, maxCount: maxCount, duration: duration)
        }
    }
    
    private let durationLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.light.font(size: 9)
        $0.textColor = .white
    }
    public var duration: Int? {
        didSet {
            updateBackgroundImageView(duration: duration)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImageView.image = HPCommonUIAsset.oneMonthCoupon.image
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        [
            logoImageView,
            studioNameLabel,
            couponNameLabel,
            countLabel
        ].forEach(backgroundImageView.addSubview(_:))
        
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(32)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
        }
        
        couponNameLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(studioNameLabel.snp.leading)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-44)
            $0.leading.equalTo(studioNameLabel.snp.leading)
        }
    }
    
    private func updateCountLabel(to count: Int, maxCount: Int, duration: Int?) {
        let newString = "잔여 횟수 \(count)/\(maxCount)회"
        let range1 = (newString as NSString).range(of: "잔여 횟수 ")
        let range2 = (newString as NSString).range(of: "\(count)")
        let range3 = (newString as NSString).range(of: "/\(maxCount)회")
        
        let normalColor = 91...180 ~= duration ?? 0 ? .white : HPCommonUIAsset.gray100.color
        
        let attributedString = NSMutableAttributedString(string: newString)
        
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.medium.font(size: 12), range: range1)
        attributedString.addAttribute(.foregroundColor, value: normalColor, range: range1)
        
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.medium.font(size: 12), range: range2)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.sub.color, range: range2)
        
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.medium.font(size: 12), range: range3)
        attributedString.addAttribute(.foregroundColor, value: normalColor, range: range3)
        
        countLabel.attributedText = attributedString
    }
    
    private func updateBackgroundImageView(duration: Int?) {
        guard let duration else {
            backgroundImageView.image = HPCommonUIAsset.seasonCoupon.image
            return
        }
        
        switch duration {
        case 1...31:
            backgroundImageView.image = HPCommonUIAsset.oneMonthCoupon.image
        case 32...90:
            backgroundImageView.image = HPCommonUIAsset.threeMonthCoupon.image
        case 91...180:
            backgroundImageView.image = HPCommonUIAsset.sixMonthCoupon.image
        case 181...270:
            backgroundImageView.image = HPCommonUIAsset.nineMonthCoupon.image
        case 271...366:
            backgroundImageView.image = HPCommonUIAsset.twelveMonthCoupon.image
        default:
            break
        }
        
        let textColor: UIColor = 91...180 ~= duration ? .white : HPCommonUIAsset.gray100.color
        studioNameLabel.textColor = textColor
        couponNameLabel.textColor = textColor
        updateCountLabel(to: count, maxCount: maxCount, duration: duration)
    }
}
