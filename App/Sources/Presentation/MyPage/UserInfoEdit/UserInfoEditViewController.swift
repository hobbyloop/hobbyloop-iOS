//
//  UserInfoEditViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/03.
//

import UIKit
import HPCommon
import HPCommonUI
import RxSwift

final class UserInfoEditViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image
        $0.configuration?.contentInsets = .init(top: 7, leading: 10, bottom: 7, trailing: 10)
    }
    
    private lazy var backButtonItem = UIBarButtonItem(customView: backButton)
    
    // MARK: - 사진 UI 및 사진 수정 버튼
    private let profileImageView = UIImageView.circularImageView(radius: 42.5).then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    private let photoEditButton = UIButton().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = HPCommonUIAsset.white.color.cgColor
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = HPCommonUIAsset.gray40.color
        $0.setImage(HPCommonUIAsset.plus.image, for: .normal)
        
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
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
        navigationItem.title = "마이페이지"
        navigationItem.leftBarButtonItem = backButtonItem
    }
}
