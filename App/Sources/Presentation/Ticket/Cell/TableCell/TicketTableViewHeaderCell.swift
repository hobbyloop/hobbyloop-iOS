//
//  TicketTableViewHeaderCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/05.
//

import UIKit

import SnapKit
import HPCommonUI

class TicketTableViewHeaderCell: UITableViewHeaderFooterView {
    private var stackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 10
            $0.axis = .horizontal
            $0.alignment = .center
        }
    }()
    
    private var ticketImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.ticketOutlined.image.withRenderingMode(.alwaysOriginal)
            $0.snp.makeConstraints {
                $0.width.equalTo(17)
                $0.height.equalTo(12)
            }
        }
    }()
    
    private var titleLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
        }
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(stackView)
        
        [ticketImageView, titleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalTo(6)
        }
    }
    
    public func configure(_ count: Int) {
        titleLabel.text = "\(count)개의 이용권"
    }
}
