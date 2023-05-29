//
//  LoginViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import UIKit

import HPCommonUI
import HPFoundation
import RxKakaoSDKAuth
import KakaoSDKUser
import Then
import SnapKit
import ReactorKit

final class LoginViewController: BaseViewController<LoginViewReactor> {
    // MARK: Property
    private lazy var loginStckView: UIStackView = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium).then {
        $0.color = .gray
    }
    
    private let logoImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.logo.image.withRenderingMode(.alwaysOriginal)
        $0.contentMode = .scaleToFill
    }
    
    private let dashLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIColors.Color.clear
    }
    
    private let backgroundImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.background.image.withRenderingMode(.alwaysOriginal)
        $0.contentMode = .scaleToFill
    }
    
    private let kakaoLoginButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.kakao.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let googleLoginButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.google.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let naverLoginButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.naver.image.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }
    
    private let appleLoginButton: UIButton = UIButton(type: .custom).then {
        $0.setImage(HPCommonUIAsset.apple.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let underLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.deepWhite.color
    }
    
    override init(reactor: LoginViewReactor?) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function)
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        dashLineView.makeDashedBorder(
            start: CGPoint(x: dashLineView.bounds.minX, y: dashLineView.bounds.minY),
            end: CGPoint(x: dashLineView.bounds.size.width, y: dashLineView.bounds.maxY),
            color: HPCommonUIAsset.deepWhite.color.cgColor
        )
    }
    
    // MARK: Configure
    private func configure() {
        
        [backgroundImageView, logoImageView, loginStckView,
         underLineView, indicatorView, dashLineView].forEach {
            view.addSubview($0)
        }
        
        [kakaoLoginButton, googleLoginButton, naverLoginButton, appleLoginButton].forEach {
            loginStckView.addArrangedSubview($0)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(65)
        }
        
        dashLineView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(35)
            $0.right.equalToSuperview().offset(-35)
            $0.height.equalTo(1)
        }
        
        loginStckView.snp.makeConstraints {
            $0.top.equalTo(dashLineView.snp.bottom).offset(103)
            $0.left.equalToSuperview().offset(45)
            $0.right.equalToSuperview().offset(-45)
            $0.height.equalTo(245)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(loginStckView.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
                
    }
    
    public override func bind(reactor: LoginViewReactor) {
        
        Observable.just(())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$isLoading)
            .asDriver(onErrorJustReturn: false)
            .drive(indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        kakaoLoginButton
            .rx.tap
            .map { Reactor.Action.didTapKakaoLogin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        appleLoginButton
            .rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = `self` else { return }
                let signUpContainer = SignUpDIContainer().makeViewController()
                self.navigationController?.pushViewController(signUpContainer, animated: true)
            }).disposed(by: disposeBag)
    }
}
