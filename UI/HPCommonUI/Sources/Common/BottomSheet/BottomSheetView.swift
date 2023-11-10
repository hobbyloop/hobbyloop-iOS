//
//  BottomSheetView.swift
//  HPCommonUI
//
//  Created by 김진우 on 10/27/23.
//

import UIKit

import HPFoundation
import RxSwift
import RxCocoa
import RxGesture

public class BottomSheetView: UIView, UIGestureRecognizerDelegate {
    
    private let whiteBoardView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    private let bar = UIButton().then {
        $0.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        $0.layer.cornerRadius = 2
    }
    
    private let disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ height: Double, subviews: (UIView, UIView) -> ()) {
        addSubview(whiteBoardView)
        whiteBoardView.addSubview(bar)
        
        bar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(5)
        }
        
        whiteBoardView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        Observable.merge(
            self.rx.tapGesture(configuration: { gesture, delegate in
                delegate.simultaneousRecognitionPolicy = .never
                gesture.delegate = self
            }).asObservable(),
            whiteBoardView.rx.tapGesture(configuration: { gesture, delegate in
                delegate.simultaneousRecognitionPolicy = .never
                gesture.delegate = self
                gesture.cancelsTouchesInView = false
            }).asObservable()
        )
        .when(.recognized)
        .bind { _ in
            print("whiteBoardView Click")
        }.disposed(by: disposeBag)
        
        
        subviews(whiteBoardView, bar)
    }
    
}

