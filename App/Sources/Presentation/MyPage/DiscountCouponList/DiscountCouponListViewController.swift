//
//  DiscountCouponListViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 5/15/24.
//

import UIKit
import HPCommonUI
import Then

/// 할인 쿠폰 목록 화면에 해당
final class DiscountCouponListViewController: UIViewController {
    // MARK: - custom navigation bar
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14))
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    // MARK: - 쿠폰 등록 파트
    private let registerCouponImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.coupon.image
    }
    
    private let registerCouponLabel = UILabel().then {
        $0.text = "쿠폰 등록"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let couponCodeTextField = UITextField().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
        $0.attributedPlaceholder = NSAttributedString(string: "쿠폰 코드를 입력하세요.", attributes: [
            .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
            .foregroundColor: HPCommonUIAsset.gray60.color
        ])
        
        $0.leftView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 10))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 10))
        $0.rightViewMode = .always
        
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = HPCommonUIAsset.gray40.color.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let registerCouponButton = UIButton().then {
        $0.setTitle("등록", for: [])
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(HPCommonUIAsset.gray100.color, for: .disabled)
        $0.backgroundColor = HPCommonUIAsset.primary.color
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.layer.cornerRadius = 8
    }
    
    private let errorMessageLabel = UILabel().then {
        $0.text = "error content"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.error.color
    }
    
    private let registerCouponPartBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 보유 쿠폰 파트
    private let ownedCouponImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.coupon.image
    }
    
    private let ownedCouponLabel = UILabel().then {
        $0.text = "쿠폰 등록"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private lazy var ownedCouponCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private let ownedCouponPartBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 유의사항 파트
    private let noticeTitleLabel = UILabel().then {
        $0.text = "쿠폰 사용 시 유의사항"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let noticeDescriptionLabel = UILabel().then {
        let text = "Kid, Adult, Senior 연령에 따라, 면밀한 움직임 분석을 통한 체계적인 레슨 및 지속적인 컨디션 캐치를 통한 운동 능력 맞춤 향상, 외부 환경으로 인한 불균형 움직임을 고려한 문적인 Pilates & Wegiht Program을 제공하고 있습니다. 필라테스 강사와 웨이트 트레이너가 함께, 회원님들의 몸을 더 건강하고 빛나는 라인으로 만들어 드리겠습니다."
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.minimumLineHeight = 17
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: HPCommonUIFontFamily.Pretendard.regular.font(size: 12),
            .foregroundColor: HPCommonUIAsset.gray60.color,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: NSNumber(floatLiteral: 0)
        ]
        
        $0.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        layout()
        configureCollectionView()
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "쿠폰"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layout() {
        [
            registerCouponImageView,
            registerCouponLabel,
            couponCodeTextField,
            registerCouponButton,
            errorMessageLabel,
            registerCouponPartBottomMarginView,
            ownedCouponImageView,
            ownedCouponLabel,
            ownedCouponCollectionView,
            ownedCouponPartBottomMarginView,
            noticeTitleLabel,
            noticeDescriptionLabel
        ].forEach(view.addSubview(_:))
        
        registerCouponImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        registerCouponLabel.snp.makeConstraints {
            $0.centerY.equalTo(registerCouponImageView.snp.centerY)
            $0.leading.equalTo(registerCouponImageView.snp.trailing).offset(6)
        }
        
        couponCodeTextField.snp.makeConstraints {
            $0.top.equalTo(registerCouponImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(48)
        }
        
        registerCouponButton.snp.makeConstraints {
            $0.centerY.equalTo(couponCodeTextField.snp.centerY)
            $0.height.equalTo(couponCodeTextField.snp.height)
            $0.width.equalTo(100)
            $0.leading.equalTo(couponCodeTextField.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        errorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(couponCodeTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        registerCouponPartBottomMarginView.snp.makeConstraints {
            $0.top.equalTo(couponCodeTextField.snp.bottom).offset(46)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        ownedCouponImageView.snp.makeConstraints {
            $0.top.equalTo(registerCouponPartBottomMarginView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        ownedCouponLabel.snp.makeConstraints {
            $0.centerY.equalTo(ownedCouponImageView.snp.centerY)
            $0.leading.equalTo(ownedCouponImageView.snp.trailing).offset(4)
        }
        
        ownedCouponCollectionView.snp.makeConstraints {
            $0.top.equalTo(ownedCouponImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(324)
        }
        
        ownedCouponPartBottomMarginView.snp.makeConstraints {
            $0.top.equalTo(ownedCouponCollectionView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        // TODO: 유의사항 파트 + 보유 쿠폰 목록 파트 레이아웃 수정
        noticeDescriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        noticeTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(noticeDescriptionLabel.snp.top).offset(-16)
        }
    }
    
    private func configureCollectionView() {
        ownedCouponCollectionView.register(HPDiscountCouponCell.self, forCellWithReuseIdentifier: HPDiscountCouponCell.identifier)
        ownedCouponCollectionView.dataSource = self
    }
}

extension DiscountCouponListViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(HPDiscountCouponCell.height)), subitems: [item])
            
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            return section
        }
    }
}

extension DiscountCouponListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 데이터 연동
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: 데이터 연동
        return collectionView.dequeueReusableCell(withReuseIdentifier: HPDiscountCouponCell.identifier, for: indexPath)
    }
}
