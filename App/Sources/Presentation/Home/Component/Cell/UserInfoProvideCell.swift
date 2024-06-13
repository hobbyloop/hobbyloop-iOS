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

public protocol ExplanationDelegate: AnyObject {
    func showOnboardingView()
}

public final class UserInfoProvideCell: UICollectionViewCell {
    
    //MARK: Property
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    public weak var delegate: ExplanationDelegate?
    
    private let nickNameLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.black.color
        $0.textAlignment = .justified
        $0.text = "안녕하세요, 김하비님"
        $0.numberOfLines = 1
    }
    
    private let ticketInfoView: HPReservedClassTicketView = HPReservedClassTicketView(
        logo: HPCommonUIAsset.logo.image,
        title: "6:1 체형교정 필라테스",
        studioName: "필라피티 스튜디오",
        instructor: "이민주 강사님",
        timeString: Date().convertToString()
    )
    
    private let explanationButton: UIButton = UIButton(type: .custom).then {
        // UIButtonConfiguration 생성
         var configuration = UIButton.Configuration.plain()
         
         // 배경 이미지 설정
         let backgroundImage = HPCommonUIAsset.ticketBlind.image
        configuration.background.image = backgroundImage
        configuration.background.imageContentMode = .scaleAspectFill
        configuration.background.backgroundInsets = NSDirectionalEdgeInsets(top: -2, leading: -10, bottom: -10, trailing: -10)
        // 구성 설정
        $0.configuration = configuration
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = HPCommonUIAsset.systemBackground.color
        
        [nickNameLabel, ticketInfoView, explanationButton].forEach {
            self.addSubview($0)
        }
        
        ticketInfoView.snp.makeConstraints {
            $0.height.equalTo(127)
            $0.top.equalTo(nickNameLabel.snp.bottom)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        explanationButton.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(ticketInfoView)
        }
        
        explanationButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.delegate?.showOnboardingView()
            }).disposed(by: disposeBag)
    }
    
}
