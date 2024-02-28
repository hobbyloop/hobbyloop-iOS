//
//  TicketViewFooterCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/05.
//

import UIKit

import HPCommonUI
import SnapKit

class TicketViewFooterCell: UICollectionViewCell {
    private var stackView: UIStackView = UIStackView().then {
        $0.spacing = 14
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private var imageStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private var ticketImageView: UIImageView = UIImageView().then {
        $0.image = HPCommonUIAsset.hpTicket.image.withRenderingMode(.alwaysOriginal)
        $0.snp.makeConstraints {
            $0.width.equalTo(52)
            $0.height.equalTo(32)
        }
    }
    
    private var labelStackView: UIStackView = UIStackView().then {
        $0.spacing = 3
        $0.axis = .vertical
    }
    
    private var titleLabel: UILabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 14)
    }
    
    private var descriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(stackView)
        
        [imageStackView, labelStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        imageStackView.addArrangedSubview(ticketImageView)
        
        imageStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        [titleLabel, descriptionLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
            $0.height.equalTo(38)
        }
        
    }
    
    public func configure(_ title: String) {
        let text = "400,000원"
        let attributedString = NSMutableAttributedString(string: text)
        let allRange = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: allRange)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.mainColor.color, range: allRange)
        
        descriptionLabel.attributedText = attributedString
        titleLabel.text = title
        backgroundColor = .clear
    }

}
