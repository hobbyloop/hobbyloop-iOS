//
//  SettingsViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/11.
//

import UIKit
import SnapKit
import Then
import HPCommonUI

class SettingsViewController: UIViewController {
    // MARK: - custom navigation bar
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14))
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    // MARK: - background view
    private let scrollView = UIScrollView()
    
    // MARK: - 앱 설정 섹션 UI
    private let appSectionStack = UIStackView().then {
        $0.backgroundColor = .systemBackground
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 0
    }
    private lazy var appSectionHeader = sectionHeader(title: "앱 설정", image: HPCommonUIAsset.settingOutlind.image)
    
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
    
    private let appSectionBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 고객지원 센터 섹션 UI
    private lazy var customerSupportSectionHeader = sectionHeader(title: "고객지원 센터", image: HPCommonUIAsset.callChat.image)
    private lazy var faqMenu = menuWithArrow(name: "자주 묻는 질문")
    private lazy var kakaoTalkQnaMenu = menuWithArrow(name: "카카오톡 1:1 문의")
    private lazy var serviceTermsMenu = menuWithArrow(name: "서비스 약관")
    private let customSupportSectionBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 로그아웃, 탈퇴하기 메뉴
    private lazy var logoutMenu = menuWithArrow(name: "로그아웃").then {
        $0.backgroundColor = .systemBackground
    }
    private let logoutMenuBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    private lazy var secessionMenu = menuWithArrow(name: "탈퇴하기").then {
        $0.backgroundColor = .systemBackground
    }
    
    // MARK: - logout bottom sheet
    private lazy var logoutBottomSheet = bottomSheet(
        title: "로그아웃 할까요?",
        description: "로그아웃 하시면 알림 서비스를 받으실 수 없어요.",
        closeButton: logoutCloseButton,
        confirmButton: logoutConfirmButton
    )
    
    private let logoutCloseButton = HPNewButton(title: "닫기", style: .secondary)
    private let logoutConfirmButton = HPNewButton(title: "로그아웃 하기", style: .primary)
    
    private var logoutBottomSheetTopConstraint: Constraint?
    
    // MARK: - secession bottom sheet
    private lazy var secessionBottomSheet = bottomSheet(
        title: "탈퇴 할까요?",
        description: "탈퇴하시면 서비스를 이용하실 수 없어요.",
        closeButton: secessionCloseButton,
        confirmButton: secessionConfirmButton
    )
    
    private let secessionCloseButton = HPNewButton(title: "닫기", style: .secondary)
    private let secessionConfirmButton = HPNewButton(title: "탈퇴하기", style: .primary)
    
    private var secessionBottomSheetTopConstraint: Constraint?
    
    // MARK: - bottom sheet background
    private let sheetBackgroundView = UIView().then {
        $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layoutBackgroundView()
        layoutAppSection()
        layoutCustomerSupportSection()
        layoutSheetBackground()
        layoutLogoutBottomSheet()
        layoutSecessionBottomSheet()
        addActions()
    }
    
    override func viewDidLayoutSubviews() {
        [logoutBottomSheet, secessionBottomSheet].forEach {
            let bezierPath = UIBezierPath(shouldRoundRect: $0.bounds, topLeftRadius: 20, topRightRadius: 20, bottomLeftRadius: 0, bottomRightRadius: 0)
            let maskLayer = CAShapeLayer()
            maskLayer.path = bezierPath.cgPath
            
            $0.layer.mask = maskLayer
            $0.clipsToBounds = true
        }
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layoutBackgroundView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func layoutAppSection() {
        appSectionBottomMarginView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        [appSectionHeader, appAlarmMenu, adAlarmMenu, homeViewMenu, versionMenu, appSectionBottomMarginView].forEach(appSectionStack.addArrangedSubview(_:))
        scrollView.addSubview(appSectionStack)
        
        appSectionStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
    }
    
    private func layoutCustomerSupportSection() {
        let customerSupportSectionStack = UIStackView()
        customerSupportSectionStack.backgroundColor = .systemBackground
        customerSupportSectionStack.axis = .vertical
        customerSupportSectionStack.alignment = .fill
        customerSupportSectionStack.spacing = 0
        
        customSupportSectionBottomMarginView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        [customerSupportSectionHeader, faqMenu, kakaoTalkQnaMenu, serviceTermsMenu, customSupportSectionBottomMarginView].forEach(customerSupportSectionStack.addArrangedSubview(_:))
        
        scrollView.addSubview(customerSupportSectionStack)
        customerSupportSectionStack.snp.makeConstraints {
            $0.top.equalTo(appSectionStack.snp.bottom).offset(14)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
        
        [logoutMenu, logoutMenuBottomMarginView, secessionMenu].forEach(scrollView.addSubview(_:))
        
        logoutMenu.snp.makeConstraints {
            $0.top.equalTo(customerSupportSectionStack.snp.bottom).offset(17)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
        
        logoutMenuBottomMarginView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(logoutMenu.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
        
        secessionMenu.snp.makeConstraints {
            $0.top.equalTo(logoutMenuBottomMarginView.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func layoutSheetBackground() {
        view.addSubview(sheetBackgroundView)
        sheetBackgroundView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        sheetBackgroundView.isHidden = true
    }
    
    private func layoutLogoutBottomSheet() {
        view.addSubview(logoutBottomSheet)
        
        logoutBottomSheet.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(285)
            self.logoutBottomSheetTopConstraint = $0.top.equalTo(view.snp.bottom).constraint
        }
    }
    
    private func layoutSecessionBottomSheet() {
        view.addSubview(secessionBottomSheet)
        
        secessionBottomSheet.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(285)
            self.secessionBottomSheetTopConstraint = $0.top.equalTo(view.snp.bottom).constraint
        }
    }
    
    // MARK: - add actions
    private func addActions() {
        // TODO: 앱 설정 섹션, 고객지원 센터 섹션의 menu button들에 action 추가
        
        logoutMenu.addTarget(self, action: #selector(showLogoutSheet), for: .touchUpInside)
        secessionMenu.addTarget(self, action: #selector(showSecessionSheet), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSheets))
        sheetBackgroundView.addGestureRecognizer(tapGesture)
        
        logoutCloseButton.addTarget(self, action: #selector(hideSheets), for: .touchUpInside)
        // TODO: 로그아웃 하기 버튼 action 수정
        logoutConfirmButton.addTarget(self, action: #selector(hideSheets), for: .touchUpInside)
        
        secessionCloseButton.addTarget(self, action: #selector(hideSheets), for: .touchUpInside)
        // TODO: 탈퇴하기 버튼 action 수정
        secessionConfirmButton.addTarget(self, action: #selector(hideSheets), for: .touchUpInside)
    }
    
    // MARK: - view generating methods
    private func sectionHeader(title: String, image: UIImage) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(62)
        }
        let titleLabel = UILabel()
        let imageView = UIImageView(image: image)
        titleLabel.text = title
        titleLabel.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        titleLabel.textColor = HPCommonUIAsset.gray100.color
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(6)
        }
        
        return view
    }
    
    private func menuWithSwitch(name: String, switchView: HPSwitch) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(57)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        nameLabel.textColor = HPCommonUIAsset.gray100.color
        
        [nameLabel, switchView].forEach(view.addSubview(_:))
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        switchView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        return view
    }
    
    private func menuWithArrow(name: String) -> UIButton {
        let view = UIButton()
        view.snp.makeConstraints {
            $0.height.equalTo(62)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        nameLabel.textColor = HPCommonUIAsset.gray100.color
        
        let arrowView = UIImageView(image: HPCommonUIAsset.rightarrow.image.withTintColor(HPCommonUIAsset.gray100.color))
        
        [nameLabel, arrowView].forEach(view.addSubview(_:))
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        arrowView.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-26)
        }
        
        return view
    }
    
    private func bottomSheet(title: String, description: String, closeButton: UIButton, confirmButton: UIButton) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let sheetImageView = UIImageView(image: HPCommonUIAsset.info.image)
        sheetImageView.snp.makeConstraints {
            $0.width.height.equalTo(34)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 20)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 16)
        
        [sheetImageView, titleLabel, descriptionLabel, closeButton, confirmButton]
            .forEach(view.addSubview(_:))
        
        sheetImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(39)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sheetImageView.snp.bottom).offset(21)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(view.snp.centerX).offset(-4.5)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.top)
            $0.height.equalTo(closeButton.snp.height)
            $0.leading.equalTo(view.snp.centerX).offset(4.5)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        return view
    }
    
    // MARK: - actions
    @objc private func showLogoutSheet() {
        sheetBackgroundView.isHidden = false
        
        logoutBottomSheetTopConstraint?.update(offset: -285)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func showSecessionSheet() {
        sheetBackgroundView.isHidden = false
        
        secessionBottomSheetTopConstraint?.update(offset: -285)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func hideSheets() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sheetBackgroundView.isHidden = true
        }
        
        logoutBottomSheetTopConstraint?.update(offset: 0)
        secessionBottomSheetTopConstraint?.update(offset: 0)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            
        }
    }
}
