//
//  PointViewController.swift
//  Hobbyloop
//
//  Created by 김남건 on 2023/09/22.
//

import UIKit
import HPCommonUI

final class PointViewController: UIViewController {
    // MARK: - 네비게이션 바
    private let backButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.leftarrow.image.imageWith(newSize: CGSize(width: 8, height: 14)), for: [])
        $0.configuration?.contentInsets = .init(top: 6, leading: 9, bottom: 6, trailing: 9)
    }
    
    // MARK: - 보유 및 소멸예정 포인트 파트
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
    
    private let pointPartBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 포인트 사용내역 파트
    private let blackPointImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.point.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = HPCommonUIAsset.gray100.color
    }
    
    private let pointHistoryContainerView = UIView()
    
    private let pointHistoryTitleLabel = UILabel().then {
        $0.text = "포인트 사용내역"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 18)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let pointHistoryTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.rowHeight = HPHistoryCell.height
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.sectionFooterHeight = 0
        $0.tableFooterView = UIView(
            frame: CGRect(origin: .zero,
                          size: CGSize(
                            width:CGFloat.leastNormalMagnitude,
                            height: CGFloat.leastNormalMagnitude
                          )
                         )
        )
    }
    private let pointHistoryPartBottomMarginView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    // MARK: - 유의사항 파트
    private let noticeTitleLabel = UILabel().then {
        $0.text = "포인트 사용 시 유의사항"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let noticeDescriptionLabel = UILabel().then {
        let text = "Kid, Adult, Senior 연령에 따라, 면밀한 움직임 분석을 통한 체계적인 레슨 및 지속적인 컨디션 캐치를 통한 운동 능력 맞춤 향상, 외부 환경으로 인한 불균형 움직임을 고려한 문적인 Pilates & Wegiht Program을 제공하고 있습니다. 필라테스 강사와 웨이트 트레이너가 함께, 회원님들의 몸을 더 건강하고 빛나는 라인으로 만들어 드리겠습니다."
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.minimumLineHeight = 17
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: HPCommonUIFontFamily.Pretendard.regular.font(size: 12),
            .foregroundColor: HPCommonUIAsset.gray60.color,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: NSNumber(floatLiteral: 0)
        ]
        
        $0.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        layout()
        configureTableView()
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
            pointPartBottomMarginView,
            pointHistoryContainerView,
            noticeTitleLabel,
            noticeDescriptionLabel
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
        
        pointPartBottomMarginView.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        pointHistoryContainerView.snp.makeConstraints {
            $0.top.equalTo(pointPartBottomMarginView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(288)
        }
        
        [
            blackPointImageView,
            pointHistoryTitleLabel,
            pointHistoryTableView,
            pointHistoryPartBottomMarginView
        ].forEach(pointHistoryContainerView.addSubview(_:))
        
        blackPointImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        pointHistoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(blackPointImageView.snp.centerY)
            $0.leading.equalTo(blackPointImageView.snp.trailing).offset(4)
        }
        
        pointHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(blackPointImageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        pointHistoryPartBottomMarginView.snp.makeConstraints {
            $0.top.equalTo(pointHistoryTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview()
        }
        
        noticeTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(noticeDescriptionLabel.snp.top).offset(-16)
        }
        
        noticeDescriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-65)
        }
    }
    
    private func configureTableView() {
        pointHistoryTableView.register(HPHistoryCell.self, forCellReuseIdentifier: HPHistoryCell.identifier)
        pointHistoryTableView.register(HPHistoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HPHistoryTableViewHeader.identifier)
        pointHistoryTableView.dataSource = self
        pointHistoryTableView.delegate = self
    }
}

// MARK: - table view data source
extension PointViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HPHistoryTableViewHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: HPHistoryTableViewHeader.identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
