//
//  HPCalendarProxyBinder.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation

import RxSwift
import ReactorKit

/**
     하비루프 Calendar business logic을 담당하는 Object 입니다.
*/
public class HPCalendarProxyBinder: HPCalendarDelgateProxy, HPCalendarBubbleDelegateProxy, HPCalendarInterface {

    //MARK: Property
    public var nowDate: Date = Date()
    public var calendarState: HPCalendarState = .now
    
    public init() { }
    /**
     HPCalendarBubbleDelegateProxy Protocol Method 이며, Weekly Calendar의 요일에 따라 Color를 Binding 처리하기 위한 Method 입니다.
     
     - Parameters:
        - day : Int Type의 날짜
     
     - Returns : HPCommonUI Assets Color Name 을 String 형식으로 반환
     */
    public func calculateDateDifference(day: Int) -> String {
        switch day {
        case 0, 6:
            return "linen"
        case 1, 5:
            return "lightPeach"
        case 2, 4:
            return "peach"
        case 3:
            return "deepOrange"
        default:
            return "deepOrange"
        }
    }
    
    /**
     HPCalendarBubbleDelegateProxy Protocol Method 이며, 모든 달의 마지막 날짜를 구하기 위한 Method 입니다.
     - Parameters:
        - month : Int Type의 월
     
     - Returns : 해당 월의 마지막 날짜를 Int Type으로 반환
     */
    public func getEndOfDays(month: Int) -> Int {
        switch month {
        case 2:
            return 28
        case 1,3,5,7,8,10,12:
            return 31
        default:
            return 30
        }
    }
    
    /**
     HPCalendarBubbleDelegateProxy Protocol Method 이며, 요일을 구하기 위한 Method 입니다.
     
     - Parameters:
        - month : Int Type의 월
        - day : Int Type의 날짜
     
     - Returns : 요일일 String Type으로 반환
     */
    public func configureBubbleCalendarWeek(month: Int, day: Int) -> String {
        var totalday: Int = 0
        let weekOfDay = nowDate.getWeekDays(identifier: "ko_KR")
        
        if month > 1 {
            for i in 1 ..< month {
                let endDay: Int = getEndOfDays(month: i)
                totalday += endDay
            }
            totalday = totalday + day
        } else if month == 1 {
            totalday = day
        }
        
        var index: Int = (totalday) % 7
        if totalday + day % 7 == 0 {
            index = 6
        } else {
            index = (totalday - 1) % 7
        }
        return weekOfDay[index]
    }
    
    /**
     HPCalendarBubbleDelegateProxy Protocol Method 이며 최종적으로 Interface를 구성하며, CalendarSectionItem에 Item을 부여해주는 Method 이다.
     
     - Returns : HPCalendarViewReactor의 (setCalendarItems) Mutation을 반환한다.
     */
    public func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< totalDays {
            if 1 > (days - startOfDays + 1) {
                continue
            }
            var weekMonthDay = days - startOfDays + 1
            var weekDay = configureBubbleCalendarWeek(month: nowDate.month, day: weekMonthDay)
            
            calendarSectionItem.append(
                CalendarSectionItem.bubbleItem(
                    HPCalendarBubbleDayCellReactor(
                        day: "\(weekMonthDay)",
                        weekDay: weekDay,
                        nowDay: "\(nowDate.day)",
                        color: weekMonthDay < nowDate.day ? "horizontalDivider" : calculateDateDifference(day: ((weekMonthDay) % 7)),
                        isCompare: weekMonthDay < nowDate.day ? true : false
                    )
                )
            )
            
        }
        
        return .just(.setCalendarItems(calendarSectionItem))
    }
    
    /**
     HPCalendarBubbleDelegateProxy Protocol Method 이며 현재시간을 Update 하기위한 Method이다
     
     - Returns : HPCalendarViewReactor의 (setBubbleCalendarDay) Mutation을 반환한다.
     */
    public func configureBubbleCalendarDay() -> Observable<HPCalendarViewReactor.Mutation> {
        return .just(.setBubbleCalendarDay(self.nowDate.day))
    }
    
    
    /**
     HPCalendarDelgateProxy Protocol Method 이며 최종적으로 Interface를 구성하여, CalendarSectionItem에 Item을 부여해주는 Method 이다.
     
     - Returns : HPCalendarViewReactor의 (setCalendarItems) Mutation을 반환한다.
     */
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
    
    /**
    HPCalendarDelgateProxy Protocol Method 다음 달의 요일을 Update 하기 위한 Method이다.
     
     - Returns : 다음 달의 요일을 Update 한 후,  HPCalendarViewReactor의 (setCalendarItems) Mutation을 반환한다.
     */
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
    
    /**
    HPCalendarDelgateProxy Protocol Method 지난 달의 요일을 Update 하기 위한 Method이다.
     
     - Returns : 지난 달의 요일을 Update 한 후,  HPCalendarViewReactor의 (setCalendarItems) Mutation을 반환한다.
     */
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
    
    /**
    HPCalendarDelgateProxy Protocol Method 이며 HPCalendarInterface nowDate의 Date Type을 update 하기 위한 Method 이다.
     
     - Returns : HPCalendarInterface nowDate를 다음 달로 Update 한 후 HPCalendarViewReactor의 (setUpdateMonthItem) Mutation을 반환한다.
     */
    public func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        
        return .just(.setUpdateMonthItem("\(self.nowDate.month)"))
    }
    
    
    /**
     HPCalendarProxyBinder의 Method 이며, 현재 월에 해당하는 일 수를 구하기 위한 Method 이다.
     - Parameters:
        - date : HPCalendarInterface의 nowDate
     
     - Returns: Int Type의 일 수를 반환
     
     */
    public func setConfigureDays(date: Date) -> Int {
        
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? Int()
    }
    
    
    /**
     HPCalendarDelgateProxy의 Method 이며, 다음 달, 지난 달을 계산하기 위한 Method
     - Parameters:
        - state : HPCalendarState 상태에 따라 Month 계산
     */
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
