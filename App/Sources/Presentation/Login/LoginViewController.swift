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
    private lazy var loginStackView: UIStackView = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 16
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
    
    private lazy var kakaoLoginButton = LoginButton(
        image: HPCommonUIAsset.kakao.image.imageWith(newSize: .init(width: 20, height: 20)).withRenderingMode(.alwaysOriginal),
        attributedTitle: NSAttributedString(
            string: "카카오톡으로 로그인",
            attributes: [
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: HPCommonUIAsset.gray100.color
            ]
        ),
        backgroundColor: HPCommonUIAsset.kakaoBackground.color
    )
    
    private lazy var googleLoginButton = LoginButton(
        image: HPCommonUIAsset.google.image.imageWith(newSize: .init(width: 18, height: 18)).withRenderingMode(.alwaysOriginal),
        attributedTitle: NSAttributedString(
            string: "구글로 로그인",
            attributes: [
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: HPCommonUIAsset.gray100.color
            ]
        ),
        backgroundColor: .white
    )
    
    private lazy var naverLoginButton = LoginButton(
        image: HPCommonUIAsset.naver.image.imageWith(newSize: .init(width: 20, height: 20)).withRenderingMode(.alwaysOriginal),
        attributedTitle: NSAttributedString(
            string: "네이버로 로그인",
            attributes: [
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: UIColor.white
            ]
        ),
        backgroundColor: HPCommonUIAsset.naverBackground.color
    )
    
    private lazy var appleLoginButton = LoginButton(
        image: UIImage(systemName: "applelogo")?.imageWith(newSize: .init(width: 16.3, height: 20)).withTintColor(.white),
        attributedTitle: NSAttributedString(
            string: "애플로 로그인",
            attributes: [
                .font: HPCommonUIFontFamily.Pretendard.medium.font(size: 14),
                .foregroundColor: UIColor.white
            ]
        ),
        backgroundColor: .black
    )
    
    private let underLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray40.color
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
        self.view.backgroundColor = HPCommonUIAsset.gray20.color
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        [logoImageView, loginStackView, underLineView, indicatorView].forEach {
            view.addSubview($0)
        }
        
        [kakaoLoginButton, googleLoginButton, naverLoginButton, appleLoginButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
            loginStackView.addArrangedSubview($0)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(126.05)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(94)
            $0.height.equalTo(67.89)
        }
        
        loginStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-174)
            $0.width.equalToSuperview().offset(-32)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-113)
            $0.leading.trailing.equalToSuperview().inset(16)
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
    private func LoginButton(image: UIImage?, attributedTitle: NSAttributedString, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(configuration: .filled())
        button.configuration?.image = image
        button.setAttributedTitle(attributedTitle, for: [])
        button.configuration?.imagePadding = 10
        button.tintColor = backgroundColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }
    
    private func didShowSignUpController(accountType: AccountType) {
        let signUpContainer = SignUpDIContainer(signUpAccountType: accountType).makeViewController()
        self.navigationController?.pushViewController(signUpContainer, animated: true)
    }
    
}
