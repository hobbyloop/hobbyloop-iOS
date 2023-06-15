//
//  UILabel+Foundation.swift
//  HPFoundation
//
//  Created by Kim dohyun on 2023/05/25.
//

import UIKit

public extension UILabel {
    
    func setAttributedText(
        targetString: String,
        font: UIFont,
        color: UIColor,
        paragraphStyle: NSMutableParagraphStyle? = nil,
        spacing: CGFloat = 0.0,
        aligment: NSTextAlignment = .natural
    ) {
        let defaultText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: defaultText)
        let targetTextRange = (defaultText as NSString).range(of: targetString)
        
        if let paragraphStyle {
            paragraphStyle.lineSpacing = spacing
            paragraphStyle.alignment = aligment
            attributedString.addAttributes([
                .font: font,
                .foregroundColor: color
            ], range: targetTextRange)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        } else {
            attributedString.addAttributes([
                .font: font,
                .foregroundColor: color
            ], range: targetTextRange)
        }
        
        self.attributedText = attributedString
    }
    
    func setSubScriptAttributed(
        targetString: String,
        font: UIFont,
        color: UIColor,
        offset: CGFloat
    ) {
            let defaultText = self.text ?? ""
            let attributedString = NSMutableAttributedString(string: defaultText)
            let targetTextRange = (defaultText as NSString).range(of: targetString)
            
            attributedString.addAttributes([
                .font: font,
                .foregroundColor: color,
                .baselineOffset: offset
            ], range: targetTextRange)
            
            self.attributedText = attributedString
        }
    
    
    func setUnderLineAttributed(
        targetString: String,
        font: UIFont,
        underlineColor: UIColor,
        textColor: UIColor
    ) {
        let defaultText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: defaultText)
        let targetTextRange = (defaultText as NSString).range(of: targetString)
        
        attributedString.addAttributes([
            .font: font,
            .underlineColor: underlineColor,
            .foregroundColor: textColor
        ], range: targetTextRange)
        
        self.attributedText = attributedString
    }
    
}
