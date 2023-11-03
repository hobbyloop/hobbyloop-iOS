//
//  FacilitInfoHeaderNavigatable.swift
//  HPCommon
//
//  Created by 김진우 on 2023/08/24.
//

import UIKit

import RxSwift

public protocol FacilityInfoHeaderNavigatable where Self: AnyObject {
    var workTimeClickEvent: PublishSubject<Void> { get }
    var reviewClickEvent: PublishSubject<Void> { get }
    var callClickEvent: PublishSubject<Void> { get }
    var messageClickEvent: PublishSubject<Void> { get }
    var disposeBag: DisposeBag { get set }
}
