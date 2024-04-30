//
//  PurchasableCouponCell.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/26/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

/// 구매 가능한 이용권을 보여주는 cell
public final class PurchasableCouponCell: UIView {
    private let bag = DisposeBag()
    
    private let photoImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    public var photoImage: UIImage? {
        get { photoImageView.image }
        set { photoImageView.image = newValue }
    }
    
    private let refundableLabel = UILabel().then {
        $0.text = "환불가능"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = .white
        $0.backgroundColor = .black.withAlphaComponent(0.5)
        $0.clipsToBounds = true
        $0.layer.maskedCorners = .init(arrayLiteral: .layerMaxXMaxYCorner)
        $0.layer.cornerRadius = 6
        $0.textAlignment = .center
    }
    
    public var isRefundable: Bool {
        get { !refundableLabel.isHidden }
        set { refundableLabel.isHidden = !newValue }
    }
    
    private let bookmarkButton = UIButton().then {
        let image = HPCommonUIAsset.archiveOutlined.image.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: [])
        $0.contentEdgeInsets = .zero
        $0.imageView?.contentMode = .scaleToFill
        $0.tintColor = .white
    }
    
    public var isBookmarked = false {
        didSet {
            let image = (isBookmarked ? HPCommonUIAsset.archiveFilled.image : HPCommonUIAsset.archiveOutlined.image)
                .withRenderingMode(.alwaysTemplate)
            bookmarkButton.tintColor = isBookmarked ? HPCommonUIAsset.primary.color : .white
            bookmarkButton.setImage(image, for: [])
        }
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "필라테스"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    public var category: String? {
        get { categoryLabel.text }
        set { categoryLabel.text = newValue }
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray60.color
    }
    
    private let addressLabel = UILabel().then {
        $0.text = "서울 강남구"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    public var address: String? {
        get { addressLabel.text }
        set { addressLabel.text = newValue }
    }
    
    private let studioNameLabel = UILabel().then {
        $0.text = "필라피티 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
        $0.lineBreakMode = .byTruncatingTail
    }
    
    public var studioName: String? {
        get { studioNameLabel.text }
        set { studioNameLabel.text = newValue }
    }
    
    private let priceLabel = UILabel().then {
        $0.text = "350,000원 ~"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.primary.color
    }
    
    public var minimumPrice: Int = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let priceString = formatter.string(from: minimumPrice as NSNumber)!
            
            priceLabel.text = "\(priceString)원 ~"
        }
    }
    
    private let starImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.star.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let gradePointLabel = UILabel().then {
        $0.text = "4.8"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    public var gradePoint: Int = 0 {
        didSet {
            gradePointLabel.text = "\(gradePoint)"
        }
    }
    
    private let reviewCountLabel = UILabel().then {
        $0.text = "(12)"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray40.color
    }
    
    public var reviewCount: Int = 0 {
        didSet {
            reviewCountLabel.text = "(\(reviewCount))"
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        photoImageView.addSubview(refundableLabel)
        
        refundableLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(58)
            $0.height.equalTo(24)
        }
        
        dividerView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        
        let upperHStack = UIStackView()
        upperHStack.axis = .horizontal
        upperHStack.alignment = .center
        upperHStack.spacing = 6
        
        [
            categoryLabel,
            dividerView,
            addressLabel
        ].forEach(upperHStack.addArrangedSubview(_:))
        
        let lowerHStack = UIStackView()
        lowerHStack.axis = .horizontal
        lowerHStack.alignment = .center
        lowerHStack.spacing = 2
        
        [
            starImageView,
            gradePointLabel,
            reviewCountLabel
        ].forEach(lowerHStack.addArrangedSubview(_:))
        
        [
            photoImageView,
            upperHStack,
            studioNameLabel,
            priceLabel,
            lowerHStack,
            bookmarkButton
        ].forEach(self.addSubview(_:))
        
        photoImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(photoImageView.snp.height)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.trailing.equalTo(photoImageView.snp.trailing).offset(-8)
            $0.bottom.equalTo(photoImageView.snp.bottom).offset(-10)
            $0.width.equalTo(26)
            $0.height.equalTo(26)
        }
        
        upperHStack.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(4)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(upperHStack.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        lowerHStack.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(4)
        }
    }
    
    private func configureButtons() {
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func bookmarkButtonTapped() {
        // TODO: 북마크 로직 구현
        isBookmarked.toggle()
    }
}
