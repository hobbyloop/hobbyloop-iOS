//
//  MyPageViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/06/03.
//

import UIKit
import SnapKit
import HPCommonUI
import Then

final class MyPageViewController: UIViewController {
    private let settingsButton = UIButton().then {
        $0.setImage(HPCommonUIAsset.settingOutlind.image, for: [])
        $0.tintColor = HPCommonUIAsset.gray100.color
    }
    
    private lazy var settingsButtonItem = UIBarButtonItem(customView: settingsButton)
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "프로필 수정"
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
}
