//
//  HPCalendarDelgateProxy.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation

import ReactorKit


public protocol HPCalendarDelgateProxy  {
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func setConfigureDays(date: Date) -> Int
}


public protocol HPCalendarBubbleDelegateProxy {
    func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func configureBubbleCalendarDay() -> Observable<HPCalendarViewReactor.Mutation>
}
