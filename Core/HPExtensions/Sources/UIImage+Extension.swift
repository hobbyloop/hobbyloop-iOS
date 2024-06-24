//
//  UIImage+Extension.swift
//  HPExtensions
//
//  Created by 김진우 on 6/21/24.
//

import UIKit
import CoreImage

public extension UIImage {
    func generateQRCode(from string: String) -> UIImage? {
        // 입력 문자열을 데이터로 변환
        let data = string.data(using: String.Encoding.ascii)
        
        // QR 코드 필터 생성
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")  // 오류 수정 레벨 설정 (L, M, Q, H 중 선택 가능)

        // 필터 출력 이미지 가져오기
        guard let qrCodeImage = filter.outputImage else { return nil }
        
        // 이미지 크기를 조정하기 위해 변환
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQRCodeImage = qrCodeImage.transformed(by: transform)
        
        // CIImage를 UIImage로 변환
        let uiImage = UIImage(ciImage: scaledQRCodeImage)
        
        return uiImage
    }
}
