//
//  HeaderView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/05/26.
//

import UIKit

import HPExtensions
import HPCommonUI
import Then
import RxSwift
import RxCocoa
import SnapKit

final class HeaderView: UIView {
    
    lazy var signatureLabel: UIImageView = {
        return UIImageView().then {
            $0.image = UIImage(named: "hobbyloop")
            addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(29)
                $0.centerY.equalTo(menuBar)
            }
        }
    }()
    
    lazy var menuBar: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.imagePadding = 5
        filled.imagePlacement = .trailing
        return UIButton(configuration: filled, primaryAction: nil).then {
            addSubview($0)
            $0.tintColor = .white
            $0.setTitle("필라테스", for: .normal)
            $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.titleLabel?.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
            $0.snp.makeConstraints {
                $0.height.equalTo(25)
                $0.bottom.equalToSuperview().offset(-12)
                $0.centerX.equalToSuperview()
            }
        }
    }()
    
    lazy var searchButton: UIButton = {
        return UIButton().then {
            $0.setImage(UIImage(named: "Searching_outlined"), for: .normal)
            $0.setImage(UIImage(named: "Searching_filled"), for: .selected)
            addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(menuBar)
                $0.leading.equalTo(menuBar.snp.trailing).offset(62)
            }
        }
    }()
    
    lazy var alarm: UIButton = {
        return UIButton().then {
            $0.setImage(UIImage(named: "Notification_outlined"), for: .normal)
            $0.setImage(UIImage(named: "Notification_filled"), for: .selected)
            addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(menuBar)
                $0.leading.equalTo(searchButton.snp.trailing).offset(13)
            }
        }
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
