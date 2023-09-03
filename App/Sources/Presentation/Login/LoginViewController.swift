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
import RxKakaoSDKAuth
import KakaoSDKUser
import Then
import SnapKit
import ReactorKit
import NaverThirdPartyLogin
import GoogleSignIn

final class LoginViewController: BaseViewController<LoginViewReactor> {
    // MARK: Property
    
    private var naverLoginInstance: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
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
        
        reactor.state
            .map { $0.isLoading }
            .asDriver(onErrorJustReturn: false)
            .drive(indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        kakaoLoginButton
            .rx.tap
            .map { Reactor.Action.didTapKakaoLogin(.kakao) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        naverLoginButton
            .rx.tap
            .map { Reactor.Action.didTapNaverLogin(.naver) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        googleLoginButton
            .rx.tap
            .map { Reactor.Action.didTapGoogleLogin(self, .google) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        appleLoginButton
            .rx.tap
            .map { Reactor.Action.didTapAppleLogin(.apple) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable
            .zip(
                reactor.state.map { $0.accountType }.distinctUntilChanged(),
                reactor.state.map { $0.authToken}.distinctUntilChanged()
            ).filter { $0.0 == .kakao && !$0.1.isEmpty }
            .map { _ in () }
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.didShowSingUpController(accountType: .kakao)
            }).disposed(by: disposeBag)
        
        Observable
            .zip(
                reactor.state.map { $0.accountType }.distinctUntilChanged(),
                reactor.state.map { $0.authToken }.distinctUntilChanged()
            ).filter { $0.0 == .naver && !$0.1.isEmpty }
            .map { _ in () }
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.didShowSingUpController(accountType: .naver)
            }).disposed(by: disposeBag)
        
        Observable
            .zip(
                reactor.state.map { $0.accountType }.distinctUntilChanged(),
                reactor.state.map { $0.authToken}.distinctUntilChanged()
            ).filter { $0.0 == .google && !$0.1.isEmpty }
            .map { _ in () }
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.didShowSingUpController(accountType: .google)
            }).disposed(by: disposeBag)
        
        Observable
            .zip(
                reactor.state.map { $0.accountType }.distinctUntilChanged(),
                reactor.state.map { $0.authToken}.distinctUntilChanged()
            ).filter { $0.0 == .apple && !$0.1.isEmpty }
            .map { _ in () }
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.didShowSingUpController(accountType: .apple)
            }).disposed(by: disposeBag)
    }
}


private extension LoginViewController {
    
    func didShowSingUpController(accountType: AccountType) {
        let signUpContainer = SignUpDIContainer(signUpClient: APIClient.shared, signUpAccountType: accountType).makeViewController()
        self.navigationController?.pushViewController(signUpContainer, animated: true)
    }
    
}
