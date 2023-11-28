//
//  LoginViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/05/08.
//

import UIKit

import HPCommonUI
import HPFoundation
import HPExtensions
import HPNetwork
import HPCommon
import Then
import SnapKit
import ReactorKit

public final class LoginViewController: BaseViewController<LoginViewReactor> {
    
    // MARK: Property
    private lazy var loginStckView: UIStackView = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.axis = .vertical
        $0.spacing = 15
    }
    
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium).then {
        $0.hidesWhenStopped = true
        $0.color = .gray
    }
    
    private let logoImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.logo.image.withRenderingMode(.alwaysOriginal)
        $0.contentMode = .scaleToFill
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
        $0.backgroundColor = HPCommonUIAsset.defaultSeparator.color
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
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        [logoImageView, loginStckView, underLineView, indicatorView].forEach {
            view.addSubview($0)
        }
        
        [kakaoLoginButton, googleLoginButton, naverLoginButton, appleLoginButton].forEach {
            loginStckView.addArrangedSubview($0)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(65)
        }
        
        loginStckView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(100)
            $0.height.equalTo(245)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(loginStckView.snp.bottom).offset(80)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
                
    }
    
    public override func bind(reactor: LoginViewReactor) {
        
        
        reactor.state
            .map { $0.isLoading }
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        kakaoLoginButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapKakaoLogin(.kakao) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        naverLoginButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapNaverLogin(.naver) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        googleLoginButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapGoogleLogin(self, .google) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        appleLoginButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapAppleLogin(.apple) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        Observable
            .combineLatest(
                reactor.state.map { $0.accountType }.distinctUntilChanged(),
                reactor.pulse(\.$authToken)
            ).filter { $0.1 != nil }
            .withUnretained(self)
            .bind(onNext: { (owner, state) in
                owner.didShowSignUpController(accountType: state.0)
            }).disposed(by: disposeBag)
    }
}


extension LoginViewController {
    
    private func didShowSignUpController(accountType: AccountType) {
        let signUpContainer = SignUpDIContainer(signUpAccountType: accountType).makeViewController()
        self.navigationController?.pushViewController(signUpContainer, animated: true)
    }
    
}
