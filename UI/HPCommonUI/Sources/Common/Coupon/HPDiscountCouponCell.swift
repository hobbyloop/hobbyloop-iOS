//
//  DiscountCouponCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 5/2/24.
//

import UIKit
import Then
import SnapKit

public final class HPDiscountCouponCell: UICollectionViewCell {
    private let discountPercentageLabel = UILabel().then {
        $0.text = "10%"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.primary.color
    }
    public var discountPercentage: Int = 0 {
        didSet {
            discountPercentageLabel.text = "\(discountPercentage)%"
        }
    }
    
    private let couponNameLabel = UILabel().then {
        $0.text = "[하비루프] 첫 구매 할인 쿠폰"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    public var couponName: String? {
        get { couponNameLabel.text }
        set { couponNameLabel.text = newValue }
    }
    
    private let exceptionLabel = UILabel().then {
        $0.text = "[일부 센터 상품 제외]"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    private let minDiscountablePriceLabel = UILabel().then {
        $0.text = "70,000원 구매시 사용 가능"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    public var minDiscountablePrice: Int! {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let priceString = formatter.string(from: minDiscountablePrice as NSNumber)!
            
            minDiscountablePriceLabel.text = "\(priceString)원 구매시 사용 가능"
        }
    }
    
    private let maxDiscountAmountLabel = UILabel().then {
        $0.text = "최대 25,000원 할인"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    public var maxDiscountAmount: Int! {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let priceString = formatter.string(from: maxDiscountAmount as NSNumber)!
            
            maxDiscountAmountLabel.text = "최대 \(priceString)원 할인"
        }
    }
    
    private let periodLabel = UILabel().then {
        $0.text = "사용 기간: 0000-00-00 ~ 0000-00-00"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    public var periodString: String? {
        get { periodLabel.text }
        set { periodLabel.text = newValue }
    }
    
    private let dashedLineView = DashedLineView(axis: .vertical, dashLength: 6, dashGap: 6, color: HPCommonUIAsset.gray40.color)
    
    private let issueButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.download.image, for: [])
        $0.contentEdgeInsets = .zero
    }
    
    private let checkmarkImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.checkMark.image
        $0.isHidden = true
    }
    
    private let issuedLabel = UILabel().then {
        $0.text = "발급완료"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray40.color
        $0.isHidden = true
    }
    var isIssued: Bool {
        get { issueButton.isHidden }
        set {
            issueButton.isHidden = newValue
            checkmarkImageView.isHidden = !newValue
            issuedLabel.isHidden = !newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureBorder()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBorder() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = HPCommonUIAsset.gray40.color.cgColor
    }
    
    private func layout() {
        let contentsVStack = UIStackView()
        contentsVStack.axis = .vertical
        contentsVStack.spacing = 4
        contentsVStack.alignment = .fill
        
        [
            exceptionLabel,
            minDiscountablePriceLabel,
            maxDiscountAmountLabel,
            periodLabel
        ].forEach { label in
            label.snp.makeConstraints {
                $0.height.equalTo(12)
            }
            
            contentsVStack.addArrangedSubview(label)
        }
        
        [
            discountPercentageLabel,
            couponNameLabel,
            contentsVStack,
            dashedLineView,
            issueButton,
            checkmarkImageView,
            issuedLabel
        ].forEach(contentView.addSubview(_:))
        
        discountPercentageLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.height.equalTo(22)
        }
        
        couponNameLabel.snp.makeConstraints {
            $0.top.equalTo(discountPercentageLabel.snp.bottom).offset(6)
            $0.leading.equalTo(discountPercentageLabel.snp.leading)
            $0.trailing.equalTo(dashedLineView.snp.leading).offset(-20)
            $0.height.equalTo(14)
        }
        
        contentsVStack.snp.makeConstraints {
            $0.top.equalTo(couponNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(discountPercentageLabel.snp.leading)
            $0.trailing.equalTo(dashedLineView.snp.leading).offset(-20)
        }
        
        dashedLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-107)
        }
        
        issueButton.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(dashedLineView.snp.trailing).offset(31)
        }
        
        checkmarkImageView.snp.makeConstraints {
            $0.width.equalTo(14)
            $0.height.equalTo(10)
            $0.leading.equalTo(dashedLineView.snp.trailing).offset(47)
            $0.top.equalToSuperview().offset(66)
        }
        
        issuedLabel.snp.makeConstraints {
            $0.top.equalTo(checkmarkImageView.snp.bottom).offset(18)
            $0.centerX.equalTo(checkmarkImageView)
        }
    }
}
