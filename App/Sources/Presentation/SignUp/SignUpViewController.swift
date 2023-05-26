//
//  SignUpViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

import HPCommonUI
import HPCommon
import HPFoundation
import ReactorKit



final class SignUpViewController: BaseViewController<SignUpViewReactor> {
    
    
    private let descriptionLabel: UILabel = UILabel().then {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        $0.text = "반가워요 회원님!\n회원님의 정보를 입력 해주세요."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.attributedText(
            targetString: "반가워요 회원님!",
            font: HPCommonUIFontFamily.Pretendard.bold.font(size: 22),
            color: HPCommonUIAsset.black.color,
            paragraphStyle: paragraphStyle,
            spacing: 10,
            aligment: .center
        )
    }
    
    private let nickNameView: SignUpInfoView = SignUpInfoView(titleType: .name)
    
    override init(reactor: SignUpViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function)
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        configure()
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        
        [descriptionLabel, nickNameView].forEach {
            view.addSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.height.equalTo(62)
            $0.centerX.equalToSuperview()
        }
        
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(100)
        }
    }
    
    
    override func bind(reactor: SignUpViewReactor) {}
}
