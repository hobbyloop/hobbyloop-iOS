//
//  TicketQRCodeView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/25.
//

import UIKit

import Then
import SnapKit


public enum QRCodeType {
    case blur
    case original
}

open class TicketQRCodeView: UIView {
        
    public var qrfilter = CIFilter(name: "CIQRCodeGenerator")
    public var qrView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public func createBlurImage(image: CIImage, transformed: CGAffineTransform) -> CGImage? {
        guard let filter = CIFilter(name: "CIBlendWithAlphaMask") else { return nil }
        let backgroundColor = CIColor(red: 255, green: 255, blue: 255, alpha: 0.2)
        let backgroundImage = CIImage(color: backgroundColor).cropped(to: image.extent).transformed(by: transformed)
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        filter.setValue(backgroundImage, forKey: kCIInputMaskImageKey)
        
        let context = CIContext()
        guard let outputImage = filter.outputImage,
              let originalImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return originalImage
    }
    
    open func createQRCode(entity: String, size: String, type: QRCodeType) {
        
        guard let filter = qrfilter, let data = entity.data(using: .ascii, allowLossyConversion: false) else { return }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(size, forKey: "inputCorrectionLevel")
        
        let transform = CGAffineTransform(scaleX: 1, y: 1)
        
        switch type {
        case .blur:
            guard let qrImage = filter.outputImage,
                  let originalImage =  createBlurImage(image: qrImage, transformed: transform) else { return }
            qrView.image = UIImage(cgImage: originalImage).withRenderingMode(.alwaysOriginal)
        case .original:
            guard let originalImage = filter.outputImage else { return }
            qrView.image = UIImage(ciImage: originalImage).withRenderingMode(.alwaysOriginal)
        }
        

    }
    
}
