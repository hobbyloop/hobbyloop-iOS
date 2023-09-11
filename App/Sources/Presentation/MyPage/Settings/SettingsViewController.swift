//
//  SettingsViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/11.
//

import UIKit
import Then
import HPCommonUI

class SettingsViewController: UIViewController {
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.text = "설정"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
    }
    
    private lazy var customNavigationBar = UIView().then {
        [backButton, navigationTitleLabel].forEach($0.addSubview(_:))
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }
    
    // MARK: - 앱 설정 섹션 UI
    private lazy var appSectionHeader = sectionHeader(title: "앱 설정", bottomMargin: 11)
    
    private let appAlarmSwitch = HPSwitch().then {
        $0.transform = CGAffineTransform(scaleX: 35 / 51, y: 21 / 31)
    }
    private lazy var appAlarmMenu = menuWithSwitch(name: "앱 알림 설정", switchView: appAlarmSwitch)
    
    private let adAlarmSwitch = HPSwitch().then {
        $0.transform = CGAffineTransform(scaleX: 35 / 51, y: 21 / 31)
    }
    private lazy var adAlarmMenu = menuWithSwitch(name: "광고 알림 설정", switchView: adAlarmSwitch)
    private lazy var homeViewMenu = menuWithArrow(name: "홈 화면 설정")
    private lazy var versionMenu = menuWithArrow(name: "버전정보")
    
    private let bottomMarginView = UIView().then {
        $0.snp.makeConstraints {
            $0.height.equalTo(12)
        }
    }
    
    // MARK: - 고객지원 센터 섹션 UI
    private lazy var customerSupportSectionHeader = sectionHeader(title: "고객지원 센터", bottomMargin: 14)
    private lazy var faqMenu = menuWithArrow(name: "자주 묻는 질문")
    private lazy var kakaoTalkQnaMenu = menuWithArrow(name: "카카오톡 1:1 문의")
    private lazy var serviceTermsMenu = menuWithArrow(name: "서비스 약관")
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(customNavigationBar)
        
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            $0.height.equalTo(56)
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = HPCommonUIAsset.lightBackground.color
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        let appSectionStack = UIStackView()
        appSectionStack.backgroundColor = .systemBackground
        appSectionStack.axis = .vertical
        appSectionStack.alignment = .fill
        appSectionStack.spacing = 0
        
        [appSectionHeader, appAlarmMenu, adAlarmMenu, homeViewMenu, versionMenu, bottomMarginView].forEach(appSectionStack.addArrangedSubview(_:))
        backgroundView.addSubview(appSectionStack)
        
        appSectionStack.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        let customerSupportSectionStack = UIStackView()
        customerSupportSectionStack.backgroundColor = .systemBackground
        customerSupportSectionStack.axis = .vertical
        customerSupportSectionStack.alignment = .fill
        customerSupportSectionStack.spacing = 0
        
        [customerSupportSectionHeader, faqMenu, kakaoTalkQnaMenu, serviceTermsMenu].forEach(customerSupportSectionStack.addArrangedSubview(_:))
        
        view.addSubview(customerSupportSectionStack)
        customerSupportSectionStack.snp.makeConstraints {
            $0.top.equalTo(appSectionStack.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func sectionHeader(title: String, bottomMargin: CGFloat) -> UIView {
        let view = UIView()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(27)
            $0.bottom.equalToSuperview().offset(-bottomMargin)
        }
        
        return view
    }
    
    private func menuWithSwitch(name: String, switchView: HPSwitch) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        
        [nameLabel, switchView].forEach(view.addSubview(_:))
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(26)
        }
        
        switchView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-23)
        }
        
        return view
    }
    
    private func menuWithArrow(name: String) -> UIButton {
        let view = UIButton()
        view.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        
        let arrowView = UIImageView(image: HPCommonUIAsset.rightarrow.image.withTintColor(HPCommonUIAsset.buttonTitle.color))
        
        [nameLabel, arrowView].forEach(view.addSubview(_:))
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(26)
        }
        
        arrowView.snp.makeConstraints {
            $0.width.equalTo(7.23)
            $0.height.equalTo(12.63)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-23.28)
        }
        
        return view
    }
}
