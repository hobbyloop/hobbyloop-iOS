//
//  ReservedClassTicketView.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/30/24.
//

import UIKit
import SnapKit
import Then

/// 예약한 수업 정보를 보여주는 ticket view
public final class ReservedClassTicketView: UIView {
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 25
    }
    
    private let classNameLabel = UILabel().then {
        $0.text = "6:1 체형교정 필라테스"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let studioNameLabel = UILabel().then {
        $0.text = "필라피티 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    private let instructorNameLabel = UILabel().then {
        $0.text = "이민주 강사님"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    
    private let horizontalLineView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    private let dateTimeLabel = UILabel().then {
        $0.text = "2023.5.12 금 09:00 - 09:50"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    
    private let dashedLineView = DashedLineView(axis: .vertical, dashLength: 6, dashGap: 6, color: HPCommonUIAsset.gray40.color)
    
    private let qrCodeView = UIImageView().then {
        $0.image = HPCommonUIAsset.qrCode.image
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        addGradientBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradientBorder() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        let startColor = HPCommonUIAsset.gradientStart.color
        let endColor = HPCommonUIAsset.gradientEnd.color
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: 40, topRightRadius: 10, bottomLeftRadius: 40, bottomRightRadius: 10, width: 2).cgPath

        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    
    
    
    private func layout() {
        self.largeContentImage = HPCommonUIAsset.reservedTicket.image
        self.snp.makeConstraints {
            $0.height.equalTo(127)
        }

        [
            logoImageView,
            classNameLabel,
            studioNameLabel,
            instructorNameLabel,
            horizontalLineView,
            dateTimeLabel,
            dashedLineView,
            qrCodeView
        ].forEach(self.addSubview(_:))
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(50)
        }
        
        classNameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(dashedLineView.snp.leading).offset(-16)
            $0.height.equalTo(14)
        }
        
        studioNameLabel.snp.makeConstraints {
            $0.top.equalTo(classNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(classNameLabel.snp.leading)
            $0.height.equalTo(12)
        }
        
        instructorNameLabel.snp.makeConstraints {
            $0.top.equalTo(studioNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(classNameLabel.snp.leading)
            $0.height.equalTo(12)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(10)
            $0.leading.equalTo(logoImageView.snp.leading)
            $0.trailing.equalTo(classNameLabel.snp.trailing)
            $0.height.equalTo(1)
        }
        
        dateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalLineView.snp.bottom).offset(10)
            $0.leading.equalTo(logoImageView.snp.leading)
            $0.trailing.equalTo(classNameLabel.snp.trailing)
        }
        
        dashedLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-98)
        }
        
        qrCodeView.snp.makeConstraints {
            $0.width.height.equalTo(68)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
