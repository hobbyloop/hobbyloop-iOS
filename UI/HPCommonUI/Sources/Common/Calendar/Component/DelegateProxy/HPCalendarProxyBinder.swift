//
//  HPCalendarProxyBinder.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation

import RxSwift
import ReactorKit


public final class HPCalendarProxyBinder: HPCalendarDelgateProxy, HPCalendarBubbleDelegateProxy, HPCalendarInterface {
    
    
    
    //MARK: Property
    public var nowDate: Date = Date()
    public var calendarState: HPCalendarState = .now
    
    
    //TODO: HPCalendar 과거 일경우 False 미래 혹은 현재 일경우 True 값으로 리턴하여 색상 변경
    
    public func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< totalDays {
            if 1 > (days - startOfDays + 1) {
                continue
            }
            if (days - startOfDays + 1) < nowDate.day {
                calendarSectionItem.append(
                    CalendarSectionItem.bubbleItem(
                        HPCalendarBubbleDayCellReactor(
                            day: "\(days - startOfDays + 1)",
                            weekDay: "월",
                            nowDay:"\(nowDate.day)",
                            color: "",
                            isCompare: false
                        )
                    )
                )
            } else {
                calendarSectionItem.append(
                    CalendarSectionItem.bubbleItem(
                        HPCalendarBubbleDayCellReactor(
                            day: "\(days - startOfDays + 1)",
                            weekDay: "월",
                            nowDay: "\(nowDate.day)",
                            color: "",
                            isCompare: true
                        )
                    )
                )
            }
        }
        
        return .just(.setCalendarItems(calendarSectionItem))
    }
    
    
    public func configureBubbleCalendarDay() -> Observable<HPCalendarViewReactor.Mutation> {
        return .just(.setBubbleCalendarDay(self.nowDate.day))
    }
    
    
    public func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .now)
        
        
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< totalDays {
            if days < startOfDays {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), isCompare: false)))
                continue
            }
            
            //TODO: 년,월,일 Compare 로직 부분 분기 처리 고민후 수정
            if Date().month == nowDate.month && (days - startOfDays + 1) < nowDate.day {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)", isCompare: false)))
            } else {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)", isCompare: true)))
            }
            
        }
        
        
        return .just(.setCalendarItems(calendarSectionItem))
    }
    
    
    public func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .next)
        var updateCalendarSectionItem: [CalendarSectionItem] = []
        var updateStartOfDays = (nowDate.weekday - 1)
        var updateTotalDays = updateStartOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< updateTotalDays {
            if days < updateStartOfDays {
                updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), isCompare: false)))
                continue
            }
            
            if Calendar.current.compare(Date(), to: nowDate, toGranularity: .month) == .orderedSame {
                if Date().month == nowDate.month && (days - updateStartOfDays + 1) < nowDate.day {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", isCompare: false)))
                } else {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", isCompare: true)))
                }
            } else {
                if Date().dateCompare(fromDate: nowDate) {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", isCompare: true)))
                } else {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", isCompare: false)))
                }
            }
        }
        
        
        return .just(.setCalendarItems(updateCalendarSectionItem))
    }
    
    
    public func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .previous)
        var previousCalendarSectionItem: [CalendarSectionItem] = []
        var previousStartOfDays = (nowDate.weekday - 1)
        var previousTotalDays = previousStartOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< previousTotalDays {
            
            if days < previousStartOfDays {
                previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), isCompare: false)))
                continue
            }
            
            if Calendar.current.compare(Date(), to: nowDate, toGranularity: .month) == .orderedSame {
                if Date().month == nowDate.month && (days - previousStartOfDays + 1) < nowDate.day {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", isCompare: false)))
                } else {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", isCompare: true)))
                }
            } else {
                if Date().dateCompare(fromDate: nowDate) {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", isCompare: true)))
                } else {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", isCompare: false)))
                }
            }

        }
        
        return .just(.setCalendarItems(previousCalendarSectionItem))
    }
    
    public func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        
        return .just(.setUpdateMonthItem("\(self.nowDate.month)"))
    }
    
    public func setConfigureDays(date: Date) -> Int {
        
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? Int()
    }
    
    
    public func updateCalendarDate(state: HPCalendarState) {
        switch state {
        case .previous:
            self.nowDate = Calendar.current.date(byAdding: DateComponents(month: -1), to: nowDate) ?? Date()
        case .next:
            self.nowDate = Calendar.current.date(byAdding: DateComponents(month: 1), to: nowDate) ?? Date()
        case .now:
            self.nowDate = Date().nowDate
        }
    }
    
    
    
    
}
