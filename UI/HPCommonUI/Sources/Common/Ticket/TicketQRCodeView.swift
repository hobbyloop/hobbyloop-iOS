//
//  TicketQRCodeView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/25.
//

import UIKit

import Then
import SnapKit

open class TicketQRCodeView: UIView {
    
    public var qrfilter = CIFilter(name: "CIQRCodeGenerator")
    public var qrView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.addSubview(qrView)
        
        qrView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    open func createQRCode(entity: String, size: String, radius: CGFloat) {
        guard let filter = qrfilter, let data = entity.data(using: .ascii, allowLossyConversion: false) else { return }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(size, forKey: "inputCorrectionLevel")
        
        let transform = CGAffineTransform(scaleX: 1, y: 1)
        
        let outputImage = filter.outputImage?.transformed(by: transform)
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(outputImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(radius, forKey: kCIInputRadiusKey)
        
        guard let originalImage = blurFilter?.outputImage else { return }
        
        qrView.image = UIImage(ciImage: originalImage).withRenderingMode(.alwaysTemplate)
    }
    
}
