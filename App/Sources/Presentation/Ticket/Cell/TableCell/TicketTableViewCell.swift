//
//  TicketTableViewCell.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/06/05.
//

import UIKit

import HPCommonUI
import SnapKit

class TicketTableViewCell: UITableViewCell {
    private var stackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 14
            $0.axis = .horizontal
            $0.alignment = .leading
            $0.distribution = .fill
        }
    }()
    
    private var imageStackView: UIStackView = {
        return UIStackView().then {
            $0.alignment = .center
            $0.distribution = .fill
        }
    }()
    
    private var ticketImageView: UIImageView = {
        return UIImageView().then {
            $0.image = HPCommonUIAsset.hpTicket.image.withRenderingMode(.alwaysOriginal)
            $0.snp.makeConstraints {
                $0.width.equalTo(52)
                $0.height.equalTo(32)
            }
        }
    }()
    
    private var labelStackView: UIStackView = {
        return UIStackView().then {
            $0.spacing = 3
            $0.axis = .vertical
        }
    }()
    
    private var titleLabel: UILabel = {
        return UILabel().then {
            $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
        }
    }()
    
    private var descriptionLabel: UILabel = {
        return UILabel()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(17)
            $0.bottom.equalToSuperview().offset(-17)
        }
        
    }
    
    public func configure(_ title: String, _ currentSeat: Int, _ maxSeat: Int) {
        let text = "예약가능 \(currentSeat) / \(maxSeat)"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (String(text) as NSString).range(of: String(currentSeat))
        let allRange = (text as NSString).range(of: text)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.medium.font(size: 12), range: allRange)
        attributedString.addAttribute(.font, value: HPCommonUIFontFamily.Pretendard.bold.font(size: 14), range: range)
        attributedString.addAttribute(.foregroundColor, value: HPCommonUIAsset.deepOrange.color, range: range)
        
        descriptionLabel.attributedText = attributedString
        titleLabel.text = title
        backgroundColor = .clear
        selectionStyle = .none
    }

}
