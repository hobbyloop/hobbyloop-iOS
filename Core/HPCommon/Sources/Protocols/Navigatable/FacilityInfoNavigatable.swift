//
//  FacilityInfoNavigatable.swift
//  Hobbyloop
//
//  Created by 김진우 on 2023/08/24.
//

import UIKit

import RxSwift

public protocol FacilityInfoNavigatable where Self: AnyObject {
    var announcementEvent: PublishSubject<Bool> { get }
    var disposeBag: DisposeBag { get set }
}
