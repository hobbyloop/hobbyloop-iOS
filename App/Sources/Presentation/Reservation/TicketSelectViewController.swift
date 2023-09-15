//
//  TicketSelectViewController.swift
//  Hobbyloop
//
//  Created by Kim dohyun on 2023/09/14.
//

import UIKit
import SnapKit
import Then
import ReactorKit

import HPCommonUI

public final class TicketSelectViewController: UIViewController {
    
    
    //MARK: Property
    private let ticketInfoLabel: UILabel = UILabel().then {
        $0.text = "3개의 이용권이 있어요"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.textAlignment = .left
    }
    
    private let ticketImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.ticket.image
    }
    
    private let ticketdescriptionLabel: UILabel = UILabel().then {
        $0.text = "어떤 이용권을 사용하실건가요?"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.lightblack.color
        $0.textAlignment = .left
    }
    
    
    private let ticketButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        $0.setTitle("이용권", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    private let loofPassButton: HPButton = HPButton(
        cornerRadius: 10,
        borderColor: HPCommonUIAsset.deepOrange.color.cgColor
    ).then {
        
        $0.setTitle("루프패스", for: .normal)
        $0.setTitleColor(HPCommonUIAsset.deepOrange.color, for: .normal)
        $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 12)
    }
    
    
    private let ticketSelectTableView: UITableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = HPCommonUIAsset.lightblack.color
        $0.estimatedRowHeight = 234
    }
    
    //MARK: LifeCycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: Configure
    
    private func configure() {
        self.view.backgroundColor = .white
        
        [ticketInfoLabel, ticketImageView, ticketdescriptionLabel,
         ticketSelectTableView, ticketButton, loofPassButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.left.equalToSuperview().offset(17)
            $0.width.equalTo(26)
            $0.height.equalTo(20)
        }
        
        ticketInfoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.left.equalTo(ticketImageView.snp.right).offset(10)
            $0.centerY.equalTo(ticketImageView)
            $0.height.equalTo(20)
        }
        
        ticketdescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(ticketInfoLabel.snp.bottom).offset(18)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        
        ticketButton.snp.makeConstraints {
            $0.top.equalTo(ticketdescriptionLabel.snp.bottom).offset(18)
            $0.left.equalTo(17)
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
        
        loofPassButton.snp.makeConstraints {
            $0.top.equalTo(ticketButton)
            $0.left.equalTo(ticketButton.snp.right).offset(8)
            $0.width.equalTo(69)
            $0.height.equalTo(26)
        }
        
        ticketSelectTableView.snp.makeConstraints {
            $0.top.equalTo(loofPassButton.snp.bottom).offset(31)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        
    }
    
    
    
    
    
}

