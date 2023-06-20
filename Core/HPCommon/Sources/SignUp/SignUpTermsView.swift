//
//  SignUpTermsView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/15.
//

import UIKit

import HPCommonUI
import HPExtensions
import ReactorKit
import SnapKit
import RxGesture
import Then


public enum SignUpTermsType: Equatable {
    case all
    case receive
    case info
    case none
    
    func setTermsTitleLabel() -> String {
        switch self {
        case .all: return "전체 동의"
        case .receive: return "마케팅 수신 정보 동의 [선택]"
        case .info: return "마케팅 정보 수집 동의 [선택]"
        case .none: return ""
        }
    }
    
    func setTermsFontColor() -> UIFont {
        switch self {
        case .all: return HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        default: return HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        }
    }
    
    
}

//TODO: SignUpTerms Type을 통해 Selected 처리 -> Reactor 추가

public final class SignUpTermsView: BaseView<SignUpTermsViewReactor> {
    
    // MARK: Property
    private let termsTitleLabel: UILabel = UILabel().then {
        $0.text = "약관 동의"
        $0.textColor = HPCommonUIAsset.black.color
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textAlignment = .left
    }
    
    private let termsUnderLineView: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.separator.color
    }

    public let termsAllView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .all)
    
    public let termsReceiveView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .receive)
    
    public let termsInfoView: SignUpTermsCheckBoxView = SignUpTermsCheckBoxView(checkBoxType: .info)
    
    public override init(reactor: SignUpTermsViewReactor? = nil) {
        super.init(reactor: reactor)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    
    private func configure() {
        
        [termsTitleLabel, termsAllView, termsUnderLineView, termsReceiveView, termsInfoView].forEach {
            addSubview($0)
        }
        
        termsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(7)
            $0.height.equalTo(20)
            $0.width.equalTo(65)
        }
        
        termsAllView.snp.makeConstraints {
            $0.top.equalTo(termsTitleLabel.snp.bottom).offset(20)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        termsUnderLineView.snp.makeConstraints {
            $0.top.equalTo(termsAllView.snp.bottom).offset(15)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        termsReceiveView.snp.makeConstraints {
            $0.top.equalTo(termsUnderLineView.snp.bottom).offset(17)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        termsInfoView.snp.makeConstraints {
            $0.top.equalTo(termsReceiveView.snp.bottom).offset(8)
            $0.left.equalTo(termsTitleLabel)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    // TODO: Figma Design대로 코드 리펙토링
    private func didTapCheckBox(type: SignUpTermsType) {
        switch type {
        case .all:
            self.termsAllView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
            self.termsInfoView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
            self.termsReceiveView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
            
        case .receive:
            self.termsReceiveView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
            
        case .info:
            self.termsInfoView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
        case .none:
            break
        }
        
    }
    
    
    public override func bind(reactor: SignUpTermsViewReactor) {
        
        termsAllView
            .checkBoxButton.rx
            .tap
            .debug("Tap Gesture All")
            .map { _ in Reactor.Action.didTapAllSelectBox(.all) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        termsReceiveView
            .checkBoxButton.rx
            .tap
            .debug("Tap Gesture Receive")
            .map { _ in Reactor.Action.didTapReceiveSelectBox(.receive) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        termsInfoView
            .checkBoxButton.rx
            .tap
            .debug("Tap Gesture Info")
            .map { _ in Reactor.Action.didTapInfoSelectBox(.info) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.allTermsType == .all }
            .map { $0.allTermsType }
            .asDriver(onErrorJustReturn: .none)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.didTapCheckBox(type: .all)
            }).disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.receiveTermsType == .receive }
            .map { $0.receiveTermsType }
            .asDriver(onErrorJustReturn: .none)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.didTapCheckBox(type: .receive)
            }).disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.infoTermsType == .info }
            .map { $0.infoTermsType }
            .asDriver(onErrorJustReturn: .none)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.didTapCheckBox(type: .info)
            }).disposed(by: disposeBag)
        
        reactor.state
            .filter { $0.allTermsType  == .none }
            .map { $0.allTermsType }
            .asDriver(onErrorJustReturn: .all)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.termsAllView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
            }).disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.receiveTermsType  == .none }
            .map { $0.receiveTermsType }
            .asDriver(onErrorJustReturn: .receive)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.termsReceiveView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
            }).disposed(by: disposeBag)
        
        
        reactor.state
            .filter { $0.infoTermsType  == .none }
            .map { $0.infoTermsType }
            .asDriver(onErrorJustReturn: .info)
            .drive(onNext: { type in
                // TODO: 추후 Figma Design 변경
                self.termsInfoView.checkBoxButton.layer.borderColor = HPCommonUIAsset.deepSeparator.color.cgColor
            }).disposed(by: disposeBag)
        
        
        
        
        
    }
    
    
}
