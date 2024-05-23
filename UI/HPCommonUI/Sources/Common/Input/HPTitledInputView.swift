//
//  HPTitledInputView.swift
//  HPCommonUI
//
//  Created by 김남건 on 5/23/24.
//

import UIKit
import SnapKit

public final class HPTitledInputView: UIView {
    public enum InputType {
        case text
        case number
        case date
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "title"
        $0.font = HPCommonUIFontFamily.Pretendard.bold.font(size: 16)
        $0.textColor = HPCommonUIAsset.gray100.color
    }
    private let textfield = HPTextField()
    private let errorMessageLabel = UILabel().then {
        $0.font = HPCommonUIFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = HPCommonUIAsset.error.color
        $0.isHidden = true
    }
    
    private let vStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
    }
    
    private let showDatePickerButton = UIButton(configuration: .plain()).then {
        $0.setImage(HPCommonUIAsset.calendarOutlined.image, for: [])
        $0.configuration?.contentInsets = .zero
        $0.isHidden = true
    }
    
    private let datePickerView = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = .init(identifier: "ko-KR")
        $0.backgroundColor = HPCommonUIAsset.gray40.color
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    public var errorMessage: String? {
        get { errorMessageLabel.text }
        set {
            errorMessageLabel.text = newValue
            errorMessageLabel.isHidden = newValue == nil
            textfield.layer.borderColor = errorMessage == nil ? HPCommonUIAsset.gray40.color
                .cgColor: HPCommonUIAsset.error.color.cgColor
        }
    }
    
    public init(title: String, isRequired: Bool, inputType: InputType, placeholder: String) {
        super.init(frame: .zero)
        setAttributedTitle(title, isRequired: isRequired)
        switch inputType {
        case .text:
            textfield.keyboardType = .default
        case .number:
            textfield.keyboardType = .numberPad
        case .date:
            textfield.isUserInteractionEnabled = false
            showDatePickerButton.isHidden = false
        }
        
        textfield.placeholderText = placeholder
        layout()
        
        showDatePickerButton.addTarget(self, action: #selector(showOrHideDatePicker), for: .primaryActionTriggered)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        textfield.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        [textfield, errorMessageLabel].forEach(vStack.addArrangedSubview(_:))
        
        [titleLabel, vStack].forEach(self.addSubview(_:))
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        vStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.addSubview(showDatePickerButton)
        showDatePickerButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.trailing.equalTo(textfield.snp.trailing).offset(-12)
            $0.centerY.equalTo(textfield.snp.centerY)
        }
        
        self.addSubview(datePickerView)
        datePickerView.snp.makeConstraints {
            $0.top.equalTo(textfield.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func showOrHideDatePicker() {
        datePickerView.isHidden.toggle()
    }
    
    private func setAttributedTitle(_ title: String, isRequired: Bool) {
        let attributedString = NSMutableAttributedString(
            string: title,
            attributes: [
                .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                .foregroundColor: HPCommonUIAsset.gray100.color
            ]
        )
        
        if isRequired {
            attributedString.append(NSAttributedString(
                string: " *",
                attributes: [
                    .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
                    .foregroundColor: HPCommonUIAsset.primary.color
                ]
            ))
        }
        
        titleLabel.attributedText = attributedString
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        for subview in subviews {
            let subviewPoint = subview.convert(point, from: self)
            if subview.point(inside: subviewPoint, with: event) { return true }
        }
        return false
    }
}
