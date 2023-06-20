//
//  ReactorKit+Extensions.swift
//  HPExtensions
//
//  Created by Kim dohyun on 2023/06/01.
//

import ReactorKit
import RxSwift
import RxCocoa


private var streams: [String: Any] = [:]

public protocol HPStreamType {
    associatedtype Event
}

public extension HPStreamType {
    
    static var event: PublishSubject<Event> {
        let key = String(describing: self)
        
        if let stream = streams[key] as? PublishSubject<Event> {
            return stream
        }
        
        let stream = PublishSubject<Event>()
        streams[key] = stream
        
        return stream
    }

}



