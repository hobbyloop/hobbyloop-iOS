//
//  BaseViewController.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/05/09.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa


open class BaseViewController<T: ReactorKit.Reactor>: UIViewController,ReactorKit.View {
        
    //MARK: Property
    public typealias Reactor = T
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    
    //MARK: Initialization
    public init(reactor: T? = nil) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    open func bind(reactor: T) {}
    
    
    public func makeDismissKeyboardGesture(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endEditing)))
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    
    

}
