//
//  PointViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/22.
//

import UIKit
import HPCommonUI

final class PointViewController: UIViewController {
    // MARK: - navigation bar back button
    private let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 22)).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image, for: .normal)
    }
    
    // MARK: - background view
    private let backgroundView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.lightBackground.color
    }
    
    // MARK: - 총 포인트 및 소멸 예정 포인트 UI
    private let pointTitleLabel = UILabel().then {
        $0.text = "내 포인트"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.pointTitleLabel.color
    }
    
    private let pointLabel = UILabel().then {
        $0.text = "50,000 P"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private let verticalDivider = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.07)
        $0.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.equalTo(98)
        }
    }
    
    private let disappearingPointTitleLabel = UILabel().then {
        $0.text = "소멸 예정"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.pointTitleLabel.color
    }
    
    private let disappearingPointLabel = UILabel().then {
        $0.text = "1,000 P"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private let disappearingDateLabel = UILabel().then {
        $0.text = "23.06.06"
        $0.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        $0.textColor = HPCommonUIAsset.disappearDate.color
    }
    
    private let pointInfoView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        configNavigationBar()
        layoutPointInfoView()
        addActions()
    }
    
    // MARK: - layout
    private func configNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "포인트"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layoutPointInfoView() {
        [
            pointTitleLabel,
            pointLabel,
            verticalDivider,
            disappearingPointTitleLabel,
            disappearingPointLabel,
            disappearingDateLabel
        ].forEach(pointInfoView.addSubview(_:))
        
        pointTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(35)
        }
        
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(pointTitleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(pointTitleLabel.snp.leading)
        }
        
        verticalDivider.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.leading.equalTo(pointLabel.snp.trailing).offset(29)
        }
        
        disappearingPointTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pointTitleLabel.snp.top)
            $0.leading.equalTo(verticalDivider.snp.trailing).offset(29)
        }
        
        disappearingPointLabel.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.top)
            $0.leading.equalTo(disappearingPointTitleLabel.snp.leading)
        }
        
        disappearingDateLabel.snp.makeConstraints {
            $0.top.equalTo(disappearingPointLabel.snp.bottom).offset(12)
            $0.leading.equalTo(disappearingPointTitleLabel.snp.leading)
        }
        
        backgroundView.addSubview(pointInfoView)
        pointInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(145)
        }
    }
    
    // MARK: - add button actions
    private func addActions() {
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
    
    // MARK: - button actions
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
