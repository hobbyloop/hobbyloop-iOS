//
//  SmallInformationCell.swift
//  HPCommonUI
//
//  Created by 김진우 on 6/10/24.
//

import UIKit


open class SmallInformationCell: UICollectionViewCell {
    // 업체 이미지
    private let cotentImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .brown
        $0.image = HPCommonUIAsset.profile.image
    }
    
    // 이미지 오른쪽 하단에 있는 북마크 모양의 버튼
    private let bookMarkButton: UIButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.archiveOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // 이미지 왼쪽 상단에 있는 "환불가능" 텍스트
    private let refundLable: UILabel = UILabel().then {
        $0.text = "환불가능"
        $0.textColor = HPCommonUIAsset.white.color
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.backgroundColor = .black.withAlphaComponent(0.5)
        $0.textAlignment = .center
    }
    
    private let companyStack: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let categoryAndNameStack: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 0
    }
    
    private let categoryStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 6
    }
    
    // 필라테스, 헬스/PT
    private let categoryLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
        $0.text = "필라테스"
    }
    
    // 서울 강남구, 서울 영등포구
    private let locationLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
        $0.text = "서울 강남구"
    }
    
    // 필라피티 스튜디오, 발란스 스튜디오
    private let companyNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
        $0.text = "필라피티 스튜디오"
    }
    
    // 350,000원 ~, 400,000원 ~
    private let priceLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.primary.color
        $0.text = "350,000원 ~"
    }
    
    // 별 4.8 (12)
    private let starStackView: UIStackView = UIStackView().then {
        $0.spacing = 2
        $0.axis = .horizontal
        $0.alignment = .leading
    }
    
    // 별 모양의 이미지
    private let starImageView: UIImageView = UIImageView().then {
        $0.tintColor = HPCommonUIAsset.sub.color
        $0.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    }
    
    // 별점 라벨
    private let starLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        $0.text = "4.8"
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    // 리뷰 수
    private let reviewCountLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        $0.text = "(12)"
        $0.textColor = HPCommonUIAsset.gray40.color
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        refundLable.customCornerRadius([0, 0, 6, 0])
    }
    
    private func configure() {
        [bookMarkButton, refundLable].forEach {
            cotentImageView.addSubview($0)
        }
        
        [cotentImageView, companyStack].forEach {
            self.contentView.addSubview($0)
        }
        
        /**
         뷰의 라벨을 모두 감싸는 CompanyStack
         */
        [categoryAndNameStack, priceLabel, starStackView].forEach {
            companyStack.addArrangedSubview($0)
        }
        
        [categoryStack, companyNameLabel].forEach {
            categoryAndNameStack.addArrangedSubview($0)
        }
        
        /**
         업종, 지역을 묶어주는 categoryStack
         */
        [categoryLabel, locationLabel].forEach {
            categoryStack.addArrangedSubview($0)
        }
        
        /**
         별, 별점, 리뷰 수를 묶어주는 starStackView
         */
        [starImageView, starLabel, reviewCountLabel, UIView()].forEach {
            starStackView.addArrangedSubview($0)
        }
        
        starImageView.snp.makeConstraints {
            $0.width.height.equalTo(12)
        }
        
        refundLable.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalTo(58)
            $0.height.equalTo(24)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(8)
        }
        
        cotentImageView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(173)
        }
        
        companyStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(4)
            $0.top.equalTo(cotentImageView.snp.bottom).offset(10)
        }
        
    }
}
