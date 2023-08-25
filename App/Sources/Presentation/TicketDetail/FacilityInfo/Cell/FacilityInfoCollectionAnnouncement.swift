//
//  FacilityInfoCollectionAnnouncement.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/24.
//

import UIKit

import RxSwift
import HPCommon
import HPCommonUI

class FacilityInfoCollectionAnnouncement: UICollectionViewCell, FacilityInfoNavigatable {
    internal lazy var announcementEvent = PublishSubject<Bool>()
    internal lazy var disposeBag = DisposeBag()
    
    private lazy var titleStackView: UIStackView = {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 6
            $0.alignment = .center
        }
    }()
    
    private lazy var titleImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.notificationFilled.image.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    private lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.text = "공지사항"
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        }
    }()
    
    private lazy var subscribeLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
            $0.textColor = HPCommonUIAsset.originSeparator.color
            $0.numberOfLines = 0
        }
    }()
    
    public lazy var openButton: UIButton = {
        return UIButton().then {
            $0.setImage(HPCommonUIAsset.downarrow.image, for: .normal)
            $0.setImage(HPCommonUIAsset.uparrow.image, for: .application)
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bind()
    }
    
    private func initLayout() {
        backgroundColor = .white
        
        [titleStackView, subscribeLabel, openButton].forEach {
            addSubview($0)
        }
        
        [titleImageView, titleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        titleImageView.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(22)
            $0.top.equalToSuperview().inset(21)
        }
        
        subscribeLabel.snp.contentCompressionResistanceVerticalPriority = 500
        
        subscribeLabel.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(21)
            $0.leading.trailing.equalTo(titleStackView)
        }
        
        openButton.snp.makeConstraints {
            $0.top.equalTo(subscribeLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(14)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    private func bind() {
        openButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            announcementEvent.onNext(false)
        }.disposed(by: disposeBag)
    }
    
    public func configure(_ subscribe: String) {
        subscribeLabel.text = subscribe
    }
    
}
