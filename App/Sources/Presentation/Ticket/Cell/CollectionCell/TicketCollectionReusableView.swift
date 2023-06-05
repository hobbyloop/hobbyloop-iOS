//
//  TicketCollectionReusableView.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/04.
//

import UIKit

import HPCommonUI
import RxSwift

public enum TicketHeaderType {
    case lank
    case location
}

class TicketCollectionReusableView: UICollectionReusableView {
    public lazy var labelStackView: UIStackView = {
        return UIStackView().then {
            addSubview($0)
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
            $0.distribution = .fill
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }()
    
    public lazy var titleLabel: UILabel = {
        return UILabel().then {
            labelStackView.addArrangedSubview($0)
            $0.text = "시설 / 이용권 조회"
            $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 22)
        }
    }()
    
    public lazy var descriptionLabel: UILabel = {
        return UILabel().then {
            labelStackView.addArrangedSubview($0)
            $0.text = "원하는 시설을 구경하고 이용권을 구매해보세요!"
            $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        }
    }()
    
    public lazy var buttonStackView: UIStackView = {
        return UIStackView().then {
            labelStackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isLayoutMarginsRelativeArrangement = false
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
    }()
    
    public lazy var lankButton: UIButton = {
        return UIButton().then {
            buttonStackView.addArrangedSubview($0)
            let text = "랭킹"
            let attributedString = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: text)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12), range: range)
            attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
            
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 13
            $0.layer.borderWidth = 1
            $0.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
        }
    }()
    
    public lazy var locationButton: UIButton = {
        return UIButton().then {
            buttonStackView.addArrangedSubview($0)
            let text = "위치"
            let attributedString = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: text)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.semiBold.font(size: 12), range: range)
            attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
            
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 13
            $0.layer.borderWidth = 1
            $0.layer.borderColor = HPCommonUIAsset.deepOrange.color.cgColor
        }
    }()
    
    public lazy var sortButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.imagePadding = 5
        filled.imagePlacement = .trailing
        return UIButton(configuration: filled, primaryAction: nil).then {
            addSubview($0)
            let text = "최신순"
            let range = (text as NSString).range(of: text)
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.regular.font(size: 12), range: range)
            $0.setAttributedTitle(attributedString, for: .normal)
            
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }()
    
    public var publish = PublishSubject<TicketHeaderType>()
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        sortButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
//            $0.width.height.equalTo(40)
        }
        
        titleLabel.textColor = .black
        descriptionLabel.textColor = .black
        
        labelStackView.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
            $0.trailing.equalTo(sortButton.snp.leading)
        }
        
        lankButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(69)
        }
        
        locationButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(69)
        }
        
        publish.subscribe { event in
            guard let event = event.element else { return }
            switch event {
                
            case .lank:
                break
            case .location:
                break
            }
        }.disposed(by: disposeBag)
    }
}
