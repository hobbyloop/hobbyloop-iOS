//
//  HPCouponCell.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/10.
//

import UIKit

import Then
import SnapKit
import ReactorKit
import RxCocoa


public final class HPCouponCell: UICollectionViewCell {
    
    public typealias Reactor = HPCouponCellReactor
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    private var pageControl: HPPageControl = HPPageControl()
    
    private lazy var couponImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.seasonCoupon.image
        $0.layer.shadowOffset = CGSize(width: 0, height: 8)
        $0.layer.shadowRadius = 10 / UIScreen.main.scale
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowColor = HPCommonUIAsset.shadow.color.cgColor
        $0.layer.masksToBounds = false
    }
    
    private let couponContentView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 9
    }
    
    private let couponTitleLabel: UILabel = UILabel().then {
        $0.text = "발란스 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.light.font(size: 10)
        $0.textColor = HPCommonUIAsset.white.color
        $0.textAlignment = .left
        
    }
    
    private let couponCountLabel: UILabel = UILabel().then {
        $0.text = "10 회"
        $0.textColor = HPCommonUIAsset.white.color
        $0.textAlignment = .left
    }
    
    private let couponDateLabel: UILabel = UILabel().then {
        $0.text = Date().convertToString()
        $0.textColor = HPCommonUIAsset.white.color
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 9)
        $0.textAlignment = .left
    }
    
    private let couponLogoImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticketlogoFilled.image
        $0.contentMode = .scaleToFill
    }
    
    
    
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        [couponTitleLabel, couponCountLabel, couponDateLabel].forEach {
            couponContentView.addArrangedSubview($0)
        }
        
        [couponContentView, couponLogoImageView].forEach {
            couponImageView.addSubview($0)
        }
        
        [pageControl, couponImageView].forEach {
            self.contentView.addSubview($0)
        }
        couponImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(179)
        }
        
        couponDateLabel.snp.makeConstraints {
            $0.height.equalTo(12)
        }
        couponCountLabel.snp.makeConstraints {
            $0.height.equalTo(21)
        }
        couponTitleLabel.snp.makeConstraints {
            $0.height.equalTo(13)
        }
        
        couponLogoImageView.snp.makeConstraints {
            $0.width.height.equalTo(94)
            $0.left.equalToSuperview().offset(47)
            $0.centerY.equalToSuperview()
        }
        
        couponContentView.snp.makeConstraints {
            $0.width.equalTo(115)
            $0.height.equalTo(66)
            $0.left.equalTo(couponLogoImageView.snp.right).offset(30)
            $0.centerY.equalTo(couponLogoImageView)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(couponImageView.snp.bottom).offset(20)
            $0.height.equalTo(8)
            $0.centerX.equalToSuperview()
        }
    }
    
}


extension HPCouponCell: ReactorKit.View {
    
    
    public func bind(reactor: Reactor) {
        reactor.state
            .map { $0.couponTitle}
            .asDriver(onErrorJustReturn: "")
            .drive(couponTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.couponCount) 회"}
            .asDriver(onErrorJustReturn: "")
            .drive(couponCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.couponDate.convertToString() }
            .asDriver(onErrorJustReturn: "")
            .drive(couponDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.numberOfPages == 0 ? true : false }
            .asDriver(onErrorJustReturn: true)
            .drive(pageControl.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.numberOfPages }
            .asDriver(onErrorJustReturn: 1)
            .drive(pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentIndex }
            .asDriver(onErrorJustReturn: 1)
            .drive(pageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.couponType.rawValue }
            .map { HPCommonUIImages.Image(named: $0, in: HPCommonUIResources.bundle, with: nil)}
            .asDriver(onErrorJustReturn: UIImage())
            .drive(couponImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
}
