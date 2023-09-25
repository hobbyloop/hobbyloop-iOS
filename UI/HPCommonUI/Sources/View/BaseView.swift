//
//  BaseView.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/06/19.
//

import UIKit
import ReactorKit


open class BaseView<T: ReactorKit.Reactor>: UIView, ReactorKit.View {

    
    
    public typealias Reactor = T
    public var disposeBag: DisposeBag = DisposeBag()
    
    public init(reactor: T? = nil) {
        defer { self.reactor = reactor }
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func bind(reactor: T) {}
}

