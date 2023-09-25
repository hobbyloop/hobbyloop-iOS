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
    
    // MARK: - 포인트 사용내역 UI
    private let pointHistoryTitleLabel = UILabel().then {
        $0.text = "포인트 사용내역"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
    }
    
    private lazy var pointHistoryTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.rowHeight = HPHistoryCell.height
        $0.register(HPHistoryCell.self, forCellReuseIdentifier: HPHistoryCell.identifier)
    }
    private let pointHistoryView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    // MARK: - 포인트 사용 시 주의사항 파트 UI
    private let pointNoticeTitleLabel = UILabel().then {
        $0.text = "포인트 사용 시 유의사항"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    private let pointNoticeContentLabel = UILabel().then {
        // TODO: 문구 수정
        $0.text = "외국인은 국제법과 조약이 정하는 바에 의하여 그 지위가 보장된다. 국가는 법률이 정하는 바에 의하여 재외국민을 보호할 의무를 진다. 국무회의는 대통령·국무총리와 15인 이상 30인 이하의 국무위원으로 구성한다. 군사재판 관할하기 위하여 특별법원으로서 군사법원을 둘 수 있다. 국회는 정부의 동의없이 정부가 제출한 지출예산 각항의 금액을 증가하거나 새 비목을 설치할 수 없다."
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.userInfoLabel.color
        $0.numberOfLines = 0
        $0.textAlignment = .justified
    }
    
    private let pointNoticeView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 12
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutBackgroundView()
        configNavigationBar()
        layoutPointInfoView()
        layoutPointHistoryView()
        layoutPointNoticeView()
        addActions()
    }
    
    // MARK: - layout
    private func layoutBackgroundView() {
        view.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
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
    
    private func layoutPointHistoryView() {
        [pointHistoryTitleLabel, pointHistoryTableView].forEach(pointHistoryView.addSubview(_:))
        
        pointHistoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(19)
        }
        
        pointHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(pointHistoryTitleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-19)
        }
        
        backgroundView.addSubview(pointHistoryView)
        
        pointHistoryView.snp.makeConstraints {
            $0.top.equalTo(pointInfoView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(243)
        }
    }
    
    private func layoutPointNoticeView() {
        [pointNoticeTitleLabel, pointNoticeContentLabel].forEach(pointNoticeView.addArrangedSubview(_:))
        
        backgroundView.addSubview(pointNoticeView)
        pointNoticeView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-47)
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
