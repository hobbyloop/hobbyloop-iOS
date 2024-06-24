//
//  ReservedClassTicketView.swift
//  HPCommonUI
//
//  Created by 김남건 on 4/30/24.
//

import UIKit
import SnapKit
import Then
import HPExtensions

/// 예약한 수업 정보를 보여주는 ticket view
public final class HPReservedClassTicketView: UIView {
    private let gradientBackgroundView = UIView()
    
    private let logoImageView = UIImageView().then {
        $0.clipsToBounds = false
        $0.backgroundColor = .black
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 25
        $0.contentMode = .scaleAspectFit
    }
    public var logoImage: UIImage? {
        get { logoImageView.image }
        set { logoImageView.image = newValue }
    }
    
    private let classNameLabel = UILabel().then {
        $0.text = "6:1 체형교정 필라테스"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    public var className: String? {
        get { classNameLabel.text }
        set { classNameLabel.text = newValue }
    }
    
    private let studioNameLabel = UILabel().then {
        $0.text = "필라피티 스튜디오"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    public var studioName: String? {
        get { studioNameLabel.text }
        set { studioNameLabel.text = newValue }
    }
    
    private let instructorNameLabel = UILabel().then {
        $0.text = "이민주 강사님"
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 12)
        $0.textColor = HPCommonUIAsset.gray60.color
    }
    public var instructorName: String? {
        didSet {
            instructorNameLabel.text = "\(instructorName) 강사님"
        }
    }
    
    private let horizontalLineView = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.gray20.color
    }
    
    private let dateTimeLabel = UILabel().then {
        $0.text = "2023.5.12 금 09:00 - 09:50"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    public var dateTimeString: String? {
        get { dateTimeLabel.text }
        set { dateTimeLabel.text = newValue }
    }
    
    private let dashedLineView = DashedLineView(axis: .vertical, dashLength: 6, dashGap: 6, color: HPCommonUIAsset.gray40.color)
    
    private let qrCodeView = UIButton().then {
        $0.setImage(HPCommonUIAsset.hpTicket.image, for: .normal)
        $0.isHidden = false
    }
    
    private var showsQRCode: String {
        get { qrData }
        set {
            let qrImage = UIImage().generateQRCode(from: newValue)
            qrCodeView.setImage(qrImage, for: .normal)
        }
    }
    
    private var qrData: String = ""
    
    public init(
        logo: UIImage,
        title: String,
        studioName: String,
        instructor: String,
        timeString: String
    ) {
        super.init(frame: .infinite)
        className = title
        self.studioName = studioName
        instructorName = instructor
        dateTimeString = timeString
        logoImage = logo
        layout()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientBackgroundView.addGradientCornerRadius(2,
                                                       [40, 10, 10, 40],
                                                       gradientColor: [HPCommonUIAsset.gradientStart.color.cgColor,
                                                                       HPCommonUIAsset.gradientEnd.color.cgColor],
                                                       gradientLocation: [0, 1])
        showsQRCode = "12345"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.largeContentImage = HPCommonUIAsset.reservedTicket.image
        self.snp.makeConstraints {
            $0.height.equalTo(127)
        }
        
        [
            gradientBackgroundView,
            logoImageView,
            classNameLabel,
            studioNameLabel,
            instructorNameLabel,
            horizontalLineView,
            dateTimeLabel,
            dashedLineView,
            qrCodeView
        ].forEach(self.addSubview(_:))
        
        gradientBackgroundView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
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
