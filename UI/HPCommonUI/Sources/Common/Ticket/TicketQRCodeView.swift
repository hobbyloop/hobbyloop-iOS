//
//  TicketQRCodeView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/10/25.
//

import UIKit
import Then



//MARK: 오버라이드 가능 여부가 있기에 open 접근자로 선언
open class TicketQRCodeView: UIView {
    
    public var qrfilter = CIFilter(name: "CIQRCodeGenerator")
    public var qrView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        
    }
    
    
    
    func createQRCode(entity: String, size: String) {
        
    }
    
}
