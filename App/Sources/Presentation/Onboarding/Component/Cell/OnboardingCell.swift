//
//  OnboardingCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/06/28.
//

import UIKit

import HPCommonUI
import ReactorKit
import Then
import SnapKit


// MARK: Delegate
public protocol OnboardingDelegate: AnyObject {
    func onboardingViewDismiss()
}


final class OnboardingCell: UICollectionViewCell {
    
    // MARK: Property
    typealias Reactor = OnboardingCellReactor
    
    public weak var delegate: OnboardingDelegate?
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    private let onboardingDeleteButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.delete.image, for: .normal)
    }
    
    private let onboardingTitleLabel: UILabel = UILabel().then {
        $0.text = "간단한 예약 방법"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 24)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private lazy var pageViewControl: HPPageControl = HPPageControl().then {
        $0.numberOfPages = 4
        $0.currentPage = 0
        $0.backgroundStyle = .minimal
    }
    
    private let onboardingImage: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private let onboardingDescriptionLabel: UILabel = UILabel().then {
        $0.numberOfLines = 2
        $0.sizeToFit()
        $0.textColor = HPCommonUIAsset.gray.color
        $0.textAlignment = .center
    }

        
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        [pageViewControl, onboardingTitleLabel, onboardingDescriptionLabel].forEach {
            self.onboardingImage.addSubview($0)
        }
        
        [onboardingImage, onboardingDeleteButton].forEach {
            self.contentView.addSubview($0)
        }
        
        onboardingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(83)
            $0.width.equalTo(180)
            $0.height.equalTo(29)
            $0.centerX.equalToSuperview()
        }
        
        onboardingImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageViewControl.snp.makeConstraints {
            $0.top.equalTo(onboardingTitleLabel.snp.bottom).offset(31)
            $0.height.equalTo(8)
            $0.centerX.equalToSuperview()
        }
        
        onboardingDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(pageViewControl.snp.bottom).offset(29)
            $0.height.greaterThanOrEqualTo(21)
            $0.centerX.equalToSuperview()
        }
        
        onboardingDeleteButton.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(44)
        }
                
    }
    
    
    
    
}



extension OnboardingCell: ReactorKit.View {
    
    
    func bind(reactor: Reactor) {
        
        
    
        reactor.state
            .map { $0.onboardingImage }
            .map { HPCommonUIImages.Image(named: $0, in: HPCommonUIResources.bundle, with: nil)}
            .debug("image Set")
            .asDriver(onErrorJustReturn: UIImage())
            .drive(onboardingImage.rx.image)
            .disposed(by: disposeBag)
        
        // TODO: Method로 특정 Target String 문자열 Font, foregroundColor 변환 하도록 구현
        reactor.state
            .map { $0.onboardingTitle }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: { description in
                if description.contains("시설 이용권 창") {
                    let attributedString = NSMutableAttributedString(string: description)
                    let targetTextRange = (description as NSString).range(of: "시설 이용권 창")
                    attributedString.addAttributes([
                        .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18),
                        .foregroundColor: HPCommonUIAsset.black.color
                    ], range: targetTextRange)
                    self.onboardingDescriptionLabel.attributedText = attributedString
                    
                } else if description.contains("이용권 창") {
                    let attributedString = NSMutableAttributedString(string: description)
                    let targetTextRange = (description as NSString).range(of: "이용권 창")
                    attributedString.addAttributes([
                        .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 18),
                        .foregroundColor: HPCommonUIAsset.black.color
                    ], range: targetTextRange)
                    self.onboardingDescriptionLabel.attributedText = attributedString
                }
            }).disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.onboardingTitle }
            .asDriver(onErrorJustReturn: "")
            .drive(onboardingDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        onboardingDeleteButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.delegate?.onboardingViewDismiss()
            }).disposed(by: disposeBag)
        
        reactor.pulse(\.$onboardingIndex)
            .asDriver(onErrorJustReturn: 0)
            .drive(pageViewControl.rx.currentPage)
            .disposed(by: disposeBag)
        
        
    }
    
}
