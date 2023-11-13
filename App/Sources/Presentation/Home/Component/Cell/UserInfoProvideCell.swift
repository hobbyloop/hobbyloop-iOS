//
//  UserInfoProvideCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/08/28.
//

import UIKit

import HPCommonUI
import RxSwift
import RxCocoa

final class UserInfoProvideCell: UICollectionViewCell {
    
    //MARK: Property
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let nickNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.gray7.color
        $0.textAlignment = .justified
        $0.text = "지원님, 반가워요!"
        $0.numberOfLines = 1
    }
    
    private let scheduleButton: UIButton = UIButton(configuration: .plain(), primaryAction: nil).then {
        $0.setImage(HPCommonUIAsset.calendarOutlined.image, for: .normal)
        $0.setImage(HPCommonUIAsset.calendarFilled.image, for: .selected)
        $0.configuration?.baseBackgroundColor = HPCommonUIAsset.backgroundColor.color
        $0.configuration?.setDefaultContentInsets()
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.attributedTitle = AttributedString(NSAttributedString(string: "예약된 수업", attributes: [
            .foregroundColor: HPCommonUIAsset.gray7.color,
            .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 18)
        ]))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.layoutIfNeeded()
        scheduleButton.configuration?.imagePadding = UIScreen.main.bounds.maxX - (58 + (scheduleButton.titleLabel?.frame.size.width ?? 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = HPCommonUIAsset.backgroundColor.color
        
        [nickNameLabel, scheduleButton].forEach {
            self.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        scheduleButton.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalTo(nickNameLabel)
            $0.bottom.equalToSuperview()
        }
        
        
        scheduleButton
            .rx.tap
            .scan(false) { lastState, newState in
                return !lastState
            }
            .map { $0 }
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isSelected in
                guard let `self` = self else { return }
                self.scheduleButton.isSelected = isSelected
                HomeViewStream.event.onNext(.reloadHomeViewSection(isSelected: isSelected))
            }).disposed(by: disposeBag)

        
    }
    
}
