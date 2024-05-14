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
    private let backButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14)), for: [])
        $0.configuration?.contentInsets = .init(top: 6, leading: 9, bottom: 6, trailing: 9)
    }
    
    private let ownedPointButton = HPNewButton(title: "사용", style: .bordered, unselectedTitleColor: HPCommonUIAsset.gray100.color).then {
        $0.layer.cornerRadius = 17
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.isSelected = true
    }
    private let expiredPointButton = HPNewButton(title: "소멸예정", style: .bordered, unselectedTitleColor: HPCommonUIAsset.gray100.color).then {
        $0.layer.cornerRadius = 17
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.isSelected = false
    }
    
    private let pointImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.point.image
    }
    
    private let pointTitleLabel = UILabel().then {
        $0.text = "보유 포인트"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    private let pointLabel = UILabel().then {
        $0.text = "50,000 P"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let expiredDateLabel = UILabel().then {
        $0.text = "2024.06.20"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
        $0.isHidden = true
    }
    
    private let dividerView1 = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    private let blackPointImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.point.image.withRenderingMode(.alwaysTemplate).withTintColor(HPCommonUIAsset.gray100.color)
    }
    
    private let pointHistoryTitleLabel = UILabel().then {
        $0.text = "포인트 사용내역"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let pointHistoryTableView = UITableView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layout()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "포인트"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func layout() {
        [
            ownedPointButton,
            expiredPointButton,
            pointImageView,
            pointTitleLabel,
            pointLabel,
            expiredDateLabel,
            dividerView1
        ].forEach(view.addSubview(_:))
        
        ownedPointButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(54)
            $0.height.equalTo(34)
        }
        
        expiredPointButton.snp.makeConstraints {
            $0.top.equalTo(ownedPointButton.snp.top)
            $0.bottom.equalTo(ownedPointButton.snp.bottom)
            $0.leading.equalTo(ownedPointButton.snp.trailing).offset(8)
            $0.width.equalTo(78)
        }
        
        pointImageView.snp.makeConstraints {
            $0.top.equalTo(ownedPointButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        pointTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(pointImageView.snp.centerY)
            $0.leading.equalTo(pointImageView.snp.trailing).offset(6)
        }
        
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(pointImageView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
        }
        
        expiredDateLabel.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dividerView1.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
}

// MARK: - table view data source
extension PointViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HPHistoryCell.identifier) as! HPHistoryCell
        cell.dateText = "03.10"
        cell.title = "필라피티 스튜디오"
        cell.historyContent = "+30,000P"
        cell.remainingAmountText = "70,000P"
        
        return cell
    }
}
