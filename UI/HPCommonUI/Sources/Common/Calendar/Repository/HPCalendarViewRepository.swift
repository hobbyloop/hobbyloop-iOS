//
//  HPCalendarViewRepository.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/20.
//

import Foundation

import ReactorKit



public protocol HPCalendarViewRepo {
    var disposeBag: DisposeBag { get }
    var calenadar: Calendar { get }
    var dateFormatter: DateFormatter { get }
    var calendarDate: Date { get set }
    
}


public final class HPCalendarViewRepository: HPCalendarViewRepo {

    //MARK: Property
    public var disposeBag: DisposeBag = DisposeBag()
    public var calenadar: Calendar = Calendar(identifier: .gregorian)
    public var dateFormatter: DateFormatter = DateFormatter()
    public var calendarDate: Date = Date()
    
    public init() { }
    
    
    
    
    
    
}
