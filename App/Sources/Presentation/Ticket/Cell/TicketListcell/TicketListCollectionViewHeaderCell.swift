//
//  TicketTableViewHeaderCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/05.
//

import UIKit

import SnapKit
import HPCommonUI
import HPCommon

class TicketListCollectionViewHeaderCell: UICollectionReusableView {
    private lazy var stackView: UIStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private lazy var ticketImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
        $0.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    private lazy var separatorView: SeparatorView = SeparatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        [stackView, separatorView].forEach {
            addSubview($0)
        }
        
        [ticketImageView, titleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    public func configure(_ count: Int) {
        titleLabel.text = "\(count)개의 이용권"
    }
}
