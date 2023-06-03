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

public enum HeaderType {
    case main
    case detail
    case none
}

public final class HeaderView: UIView {
    
    public lazy var signatureLabel: UIImageView = {
        return UIImageView().then {
            addSubview($0)
            $0.image = HPCommonUIAsset.hobbyloop.image.withRenderingMode(.alwaysOriginal)
        }
    }()
    
    public lazy var menuBar: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.imagePadding = 5
        filled.imagePlacement = .trailing
        return UIButton(configuration: filled, primaryAction: nil).then {
            addSubview($0)
            
            let text = "필라테스"
            let range = (text as NSString).range(of: text)
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16), range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
            
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }()
    
    public lazy var searchButton: UIButton = {
        return UIButton().then {
            addSubview($0)
            $0.setImage(HPCommonUIAsset.searchingOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.setImage(HPCommonUIAsset.searchingFilled.image.withRenderingMode(.alwaysOriginal), for: .selected)
        }
    }()
    
    public lazy var alarm: UIButton = {
        return UIButton().then {
            addSubview($0)
            $0.setImage(HPCommonUIAsset.notificationOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.setImage(HPCommonUIAsset.notificationFilled.image.withRenderingMode(.alwaysOriginal), for: .selected)
        }
    }()
    
    public lazy var backButton: UIButton = {
        return UIButton().then {
            addSubview($0)
            $0.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
    }()
    
    public lazy var centerLabel: UILabel = {
        return UILabel().then {
            addSubview($0)
            $0.text = storeName ?? "발란스 스튜디오"
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
            
        }
    }()
    
    public lazy var moreButton: UIButton = {
        return UIButton().then {
            addSubview($0)
            $0.setImage(UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
    }()
    
    public lazy var archiveButton: UIButton = {
        return UIButton().then {
            addSubview($0)
            $0.setImage(HPCommonUIAsset.archiveOutlined.image.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
    }()
    
    private var storeName: String?
    
    public init(type: HeaderType, storeName: String? = nil) {
        super.init(frame: .zero)
        configure(type, storeName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ type: HeaderType, _ name: String?) {
        storeName = name
        switch type {
            
        case .main:
            signatureLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(29)
                $0.centerY.equalTo(menuBar)
            }
            
            menuBar.snp.makeConstraints {
                $0.height.equalTo(25)
                $0.bottom.equalToSuperview().offset(-12)
                $0.centerX.equalToSuperview()
            }
            
            searchButton.snp.makeConstraints {
                $0.centerY.equalTo(menuBar)
                $0.trailing.equalTo(alarm.snp.leading).offset(-16)
            }
            
            alarm.snp.makeConstraints {
                $0.centerY.equalTo(menuBar)
                $0.trailing.equalToSuperview().offset(-20)
            }
            
        case .detail:
            
            backButton.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(29)
                $0.centerY.equalTo(centerLabel)
            }
            
            centerLabel.snp.makeConstraints {
                $0.height.equalTo(25)
                $0.bottom.equalToSuperview().offset(-12)
                $0.centerX.equalToSuperview()
            }
            
            moreButton.snp.makeConstraints {
                $0.centerY.equalTo(centerLabel)
                $0.trailing.equalTo(archiveButton.snp.leading).offset(-16)
            }
            
            archiveButton.snp.makeConstraints {
                $0.centerY.equalTo(centerLabel)
                $0.trailing.equalToSuperview().offset(-20)
            }
            
        case .none:
            break
        }
    }
    
}
