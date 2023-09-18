//
//  HPCalendarDelgateProxy.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation

import ReactorKit

/**
     하비루프 Monthly Calendar 구현을 위한 Interface 입니다.
*/
public protocol HPCalendarDelgateProxy  {
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func setConfigureDays(date: Date) -> Int
}

/**
     하비루프 Weekly Calendar 구현을 위한 Interface 입니다.
 */
public protocol HPCalendarBubbleDelegateProxy {
    func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func configureBubbleCalendarDay() -> Observable<HPCalendarViewReactor.Mutation>
    func configureBubbleCalendarWeek(month: Int, day: Int) -> String
    func getEndOfDays(month: Int) -> Int
    func calculateDateDifference(day: Int) -> String
}
