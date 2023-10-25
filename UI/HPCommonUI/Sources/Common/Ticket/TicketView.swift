//
//  TicketView.swift
//  HPCommonUI
//
//  Created by 김남건 on 2023/07/15.
//

import UIKit
import SnapKit


// TODO: 추후 Reactor 로 UI Configure 처리
public enum TicketStatus {
    case launch
    case release
}


/// 수업 예약 내용을 나타내는 ticket view
public final class TicketView: UIView {
    
    private let fillColor: CGColor
    private let textColor: UIColor
    
    private let containerView: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let photoView = UIImageView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 24.5
        $0.clipsToBounds = true
        
        $0.snp.makeConstraints {
            $0.width.equalTo(49)
            $0.height.equalTo(49)
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
    }
    
    private let studioLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 11)
    }
    
    private let instructorLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 11)
    }
    
    private let dividerLine = UIView().then {
        $0.backgroundColor = HPCommonUIAsset.lightSeparator.color
        $0.snp.makeConstraints {
            $0.width.equalTo(192)
            $0.height.equalTo(1)
        }
    }
    
    private let timeLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.semiBold.font(size: 14)
    }
    
    private let logoView = UIImageView().then {
        $0.image = HPCommonUIAsset.logo.image
        
        $0.snp.makeConstraints {
            $0.width.equalTo(33.58)
            $0.height.equalTo(23.7)
        }
    }
    
    public init(
        title: String,
        studioName: String,
        instructor: String,
        timeString: String,
        textColor: UIColor,
        fillColor: CGColor
    ) {
        self.textColor = textColor
        self.fillColor = fillColor
        super.init(frame: .infinite)
        titleLabel.text = title
        studioLabel.text = studioName
        instructorLabel.text = "\(instructor) 강사님"
        timeLabel.text = timeString
        setLayoutColor(color: textColor)
        layout()
    }
    
    
    private func setLayoutColor(color: UIColor) {
        self.titleLabel.textColor = color
        self.studioLabel.textColor = color
        self.instructorLabel.textColor = color
        self.timeLabel.textColor = color
        self.dividerLine.backgroundColor = color
    }
    
    private func layout() {
        
        self.addSubview(containerView)
        [photoView, titleLabel, studioLabel, instructorLabel, dividerLine, timeLabel, logoView].forEach(self.addSubview(_:))
                
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        photoView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(24)
            $0.leading.equalTo(self.snp.leading).offset(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.top)
            $0.leading.equalTo(photoView.snp.trailing).offset(17.7)
        }
        
        studioLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        instructorLabel.snp.makeConstraints {
            $0.top.equalTo(studioLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        dividerLine.snp.makeConstraints {
            $0.top.equalTo(instructorLabel.snp.bottom).offset(13)
            $0.leading.equalTo(self.snp.leading).offset(24)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dividerLine.snp.bottom).offset(11)
            $0.leading.equalTo(self.snp.leading).offset(27)
        }
        
        logoView.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).offset(-51.42)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createDashLineLayer(frame: CGRect) -> CAShapeLayer {
        let midLineLayer = CAShapeLayer()
        midLineLayer.strokeColor = self.textColor.cgColor
        midLineLayer.lineWidth = 0.5
        midLineLayer.lineDashPattern = [10, 10]
        let cgPath = CGMutablePath()
        midLineLayer.path = cgPath
        
        return midLineLayer
    }
    
    public override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(shouldRoundRect: self.bounds, topLeftRadius: 40, topRightRadius: 10, bottomLeftRadius: 40, bottomRightRadius: 10)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        
        maskLayer.fillColor = self.fillColor
        maskLayer.strokeColor = HPCommonUIAsset.lightSeparator.color.cgColor
        maskLayer.lineWidth = 1
        
        
        self.containerView.layer.addSublayer(maskLayer)
        self.containerView.layer.addSublayer(createDashLineLayer(frame: rect))
    }
}
