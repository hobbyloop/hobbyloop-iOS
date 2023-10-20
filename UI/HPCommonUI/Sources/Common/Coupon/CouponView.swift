//
//  CouponView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/05/30.
//

import UIKit

import SnapKit
import Then

public final class CouponView: UIView {
    private let backgroundImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.oneMonthCoupon.image
    }
    
    private let logoImageView = UIImageView().then {
        $0.sizeToFit()
        $0.snp.makeConstraints { make in
            make.width.equalTo(79)
            make.height.equalTo(62)
        }
    }
    
    private let companyNameLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.light.font(size: 10)
        $0.textColor = .white
    }
    
    private let countLabel = UILabel()
    
    private let periodLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.light.font(size: 9)
        $0.textColor = .white
    }
    
    var count: Int = 0 {
        didSet {
            updateCountLabel(to: count)
        }
    }
    
    public init(coupon: DummyCoupon) {
        super.init(frame: .infinite)
        
        companyNameLabel.text = coupon.companyName
        self.count = coupon.count
        updateCountLabel(to: coupon.count)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd"
        
        periodLabel.text = "\(dateformatter.string(from: coupon.start)) - \(dateformatter.string(from: coupon.end))"
        
        let days = Int(coupon.end.timeIntervalSince(coupon.start)) / (24 * 60 * 60) + 1
        
        switch days {
        case 1...31:
            backgroundImageView.image = HPCommonUIAsset.oneMonthCoupon.image
        case 32...90:
            backgroundImageView.image = HPCommonUIAsset.threeMonthCoupon.image
        case 91...180:
            backgroundImageView.image = HPCommonUIAsset.sixMonthCoupon.image
        case 181...240:
            backgroundImageView.image = HPCommonUIAsset.nineMonthCoupon.image
        case 241...365:
            backgroundImageView.image = HPCommonUIAsset.twelveMonthCoupon.image
        default:
            backgroundImageView.image = HPCommonUIAsset.seasonCoupon.image
        }
        
        [companyNameLabel, countLabel, periodLabel].forEach {
            $0.textColor = ((91...180) ~= days) ? .white : .black
        }
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let labelsStack = UIStackView()
        labelsStack.axis = .vertical
        labelsStack.alignment = .leading
        labelsStack.spacing = 9
        
        [companyNameLabel, countLabel, periodLabel].forEach(labelsStack.addArrangedSubview(_:))
        
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 46
        
        [logoImageView, labelsStack].forEach(contentStack.addArrangedSubview(_:))
        
        backgroundImageView.addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundImageView.snp.centerX).offset(10)
            make.centerY.equalTo(backgroundImageView.snp.centerY)
        }
        
    }
    
    private func updateCountLabel(to count: Int) {
        let newString = "\(count) 회"
        let countLabelRange = (newString as NSString).range(of: "\(count)")
        let countUnitLabelRange = (newString as NSString).range(of: "회")
        
        let attributedString = NSMutableAttributedString(string: newString)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16), range: countLabelRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: countUnitLabelRange)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.regular.font(size: 12), range: countUnitLabelRange)
        
        countLabel.attributedText = attributedString
    }
}
