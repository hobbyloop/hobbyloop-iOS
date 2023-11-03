//
//  SignUpBottomSheetView.swift
//  HPCommon
//
//  Created by Kim dohyun on 2023/06/19.
//

import UIKit

import HPCommonUI
import Then
import SnapKit
import RxSwift
import RxCocoa


public protocol SignUpBottomSheetDelegate: AnyObject {
    func updateToBirthDay(birthday: Date)
}


public final class SignUpBottomSheetView: UIViewController {
    
    
    //MARK: Property
    public weak var delegate: SignUpBottomSheetDelegate?
    
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let containerView: UIView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = HPCommonUIAsset.separator.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.backgroundColor = HPCommonUIAsset.white.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private let datePickerView: UIDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.tintColor = .separator
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        _ = $0.subviews.map { $0.setValue(HPCommonUIColors.Color.clear, forKey: "magnifierLineColor") }
    }
    
    private let doneButton: UIButton = UIButton(type: .system).then {
        $0.setAttributedTitle(NSAttributedString(string: "완료", attributes: [
            .font: HPCommonUIFontFamily.Pretendard.bold.font(size: 16),
            .foregroundColor: HPCommonUIAsset.black.color
        ]), for: .normal)
    }
    
    
    
    //MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: Configure
    private func configure() {
        
        [datePickerView, doneButton].forEach { containerView.addSubview($0) }
        
        view.addSubview(containerView)
        
        
        containerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(271)
        }
        
        doneButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(44)
        }
        
        datePickerView.snp.makeConstraints {
            $0.width.equalTo(319)
            $0.height.equalTo(143)
            $0.center.equalToSuperview()
        }
        
        
        doneButton
            .rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        
        datePickerView
            .rx
            .date
            .changed
            .subscribe(onNext: { date in
                self.delegate?.updateToBirthDay(birthday: date)
            }).disposed(by: disposeBag)
        
        
    }
    
    
}
