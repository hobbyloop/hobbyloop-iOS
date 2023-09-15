//
//  TicketSelectCell.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import UIKit

import Then
import SnapKit
import HPCommonUI

public final class TicketSelectCell: UITableViewCell {
    
    //MARK: Property
    private let iconImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = HPCommonUIAsset.pilatesFilled.image
    }
    
    private let nameLabel: UILabel = UILabel().then {
        $0.text = "발란스 스튜디오"
    }
    
    private let underLine: UIView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.mercury.color
    }
    
    private let ticketInfoTableView: UITableView = UITableView().then {
        $0.separatorStyle = .none
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configure
    private func configure() {
        [iconImageView, nameLabel, underLine, ticketInfoTableView].forEach {
            self.contentView.addSubview($0)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(26)
            $0.height.equalTo(21)
            $0.top.equalToSuperview().offset(28)
            $0.left.equalToSuperview().offset(29)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31)
            $0.left.equalTo(iconImageView.snp.right).offset(11)
            $0.height.equalTo(14)
            $0.centerY.equalTo(iconImageView)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(17)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(14)
            $0.right.equalToSuperview().offset(-14)
        }
        
        ticketInfoTableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
}


