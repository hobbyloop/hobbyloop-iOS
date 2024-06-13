//
//  ExplanationCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/07/12.
//

import UIKit

import HPCommonUI
import Then
import RxSwift
import RxCocoa

final class ExplanationCell: UICollectionViewCell {
    
    //MARK: Property
    private var disposeBag: DisposeBag = DisposeBag()
    
    public weak var delegate: ExplanationDelegate?
    
    private let explanationContainerView: UIView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private let explanationTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 24)
        $0.textColor = HPCommonUIAsset.black.color
        $0.text = "처음이세요?"
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    private let explanationSubTitleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        $0.textColor = HPCommonUIAsset.originSeparator.color
        $0.text = "이용권을 구매해 수업을 예약해보세요!"
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    
    private let explanationButton: UIButton = UIButton(type: .custom).then {
        $0.setAttributedTitle(NSAttributedString(
            string: "사용 설명 펼쳐보기 ",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: HPCommonUIAsset.black.color,
                .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                .foregroundColor: HPCommonUIAsset.black.color
                
            ]
        ), for: .normal)
    }
    
    
    //TODO: StartDate, EndDate 값 추후 Server Date 값 Binding 처리
    private let explanationCouponView: TicketView = TicketView(
        title: "1:1 맞춤지도 20회",
        studioName: "하비루프 스튜디오",
        instructor: "김하비 강사님",
        timeString: Date().convertToString(),
        textColor: HPCommonUIAsset.white.color,
        fillColor: HPCommonUIAsset.deepOrange.color.cgColor
    )
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        
        self.contentView.addSubview(explanationContainerView)
        
        [explanationTitleLabel, explanationSubTitleLabel, explanationCouponView ,explanationButton].forEach {
            self.explanationContainerView.addSubview($0)
        }
        
        explanationContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        explanationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.width.equalTo(120)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        explanationSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(explanationTitleLabel.snp.bottom).offset(30)
            $0.width.equalTo(250)
            $0.height.equalTo(15)
            $0.centerX.equalTo(explanationTitleLabel)
        }
        
        explanationCouponView.snp.makeConstraints {
            $0.top.equalTo(explanationSubTitleLabel.snp.bottom).offset(21)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(152)
            
        }
        
        explanationButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(20)
            $0.top.equalTo(explanationCouponView.snp.bottom).offset(30)
            $0.centerX.equalTo(explanationSubTitleLabel)
        }
        
        explanationButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.delegate?.showOnboardingView()
            }).disposed(by: disposeBag)
        
        
    }
    
}
