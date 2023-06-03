//
//  CouponView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/05/30.
//

import UIKit
import SnapKit

public class CouponView: UIView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.snp.makeConstraints { make in
            make.width.equalTo(79)
            make.height.equalTo(62)
        }
        
        return imageView
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.light.font(size: 10)
        label.textColor = .white
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = UIColor(red: 0xDC / 255, green: 0xFF / 255, blue: 0x05 / 255, alpha: 1)
        
        return label
    }()
    
    private let countUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "회"
        label.font = HPCommonUIFontFamily.Pretendard.regular.font(size: 12)
        label.textColor = .white
        
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font = HPCommonUIFontFamily.Pretendard.light.font(size: 9)
        label.textColor = .white
        
        return label
    }()
    
    public init(companyName: String, count: Int, start: Date, end: Date) {
        super.init(frame: .infinite)
        
        companyNameLabel.text = companyName
        countLabel.text = "\(count)"
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd"
        
        periodLabel.text = "\(dateformatter.string(from: start)) - \(dateformatter.string(from: end))"
        self.backgroundColor = .black
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        let countLabelStack = UIStackView()
        countLabelStack.axis = .horizontal
        countLabelStack.alignment = .center
        countLabelStack.spacing = 4
        
        countLabelStack.addArrangedSubview(countLabel)
        countLabelStack.addArrangedSubview(countUnitLabel)
        
        let labelsStack = UIStackView()
        labelsStack.axis = .vertical
        labelsStack.alignment = .leading
        labelsStack.spacing = 9
        
        [companyNameLabel, countLabelStack, periodLabel].forEach(labelsStack.addArrangedSubview(_:))
        
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 46
        
        [logoImageView, labelsStack].forEach(contentStack.addArrangedSubview(_:))
        
        self.addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
