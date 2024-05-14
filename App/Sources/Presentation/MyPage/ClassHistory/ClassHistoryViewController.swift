//
//  ClassHistoryViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 5/14/24.
//

import UIKit
import HPCommonUI
import SnapKit

final class ClassHistoryViewController: UIViewController {
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14))
        
        $0.snp.makeConstraints {
            $0.width.equalTo(21)
            $0.height.equalTo(22)
        }
    }
    
    // MARK: - 년, 월 label 및 prev, next button
    private let yearMonthLabel = UILabel().then {
        $0.text = "2024년 5월"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let prevMonthButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14)).withRenderingMode(.alwaysTemplate), for: [])
        $0.configuration?.contentInsets = .init(top: 6, leading: 9, bottom: 6, trailing: 9)
        $0.tintColor = HPCommonUIAsset.gray100.color
    }
    
    private let nextMonthButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14)).withRenderingMode(.alwaysTemplate), for: [])
        $0.imageView?.transform = $0.imageView?.transform.rotated(by: .pi) ?? .identity
        $0.configuration?.contentInsets = .init(top: 6, leading: 9, bottom: 6, trailing: 9)
        $0.isEnabled = false
        $0.tintColor = HPCommonUIAsset.gray40.color
    }
    
    private let yearMonthStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 14
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        layout()
    }
    
    private func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: HPCommonUIAsset.gray100.color,
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        ]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationItem.title = "수업 내역"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layout() {
        [prevMonthButton, yearMonthLabel, nextMonthButton].forEach(yearMonthStack.addArrangedSubview(_:))
        [
            yearMonthStack
        ].forEach(view.addSubview(_:))
        
        yearMonthStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
