//
//  TicketDetailNavigatable.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/24.
//

import UIKit

import RxSwift

public protocol TicketDetailNavigatable where Self: AnyObject {
    var item: PublishSubject<String> { get }
    var disposeBag: DisposeBag { get set }
}
