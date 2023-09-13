//
//  HPCalendarViewReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/20.
//

import Foundation

import ReactorKit
import RxSwift


public final class HPCalendarViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    public var calendarConfigureProxy: HPCalendarDelgateProxy & HPCalendarBubbleDelegateProxy & HPCalendarInterface = HPCalendarProxyBinder()
    
    
    //MARK: Action
    public enum Action {
        case changeCalendarStyle(CalendarStyle)
        case didTapNextDateButton
        case didTapPreviousDateButton
    }
    
    //MARK: Mutation
    public enum Mutation {
        case setCalendarItems([CalendarSectionItem])
        case updateCalendarStyle(CalendarStyle)
        case setUpdateMonthItem(String)
        case setBubbleCalendarDay(Int)
    }
    
    //MARK: State
    public struct State {
        var days: [String]
        var month: String
        var nowDay: Int
        var style: CalendarStyle
        @Pulse var section: [CalendarSection]
    }
    
    
    public init() {
        self.initialState = State(
            days: [],
            month: "",
            nowDay: 1,
            style: .default,
            section: [
                .calendar([])
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
            
        case .didTapNextDateButton:
            return .concat(
                calendarConfigureProxy.updateNextDateCalendar(),
                calendarConfigureProxy.updateNextMonthCalendar()
            )
        case .didTapPreviousDateButton:
            
            return .concat(
                calendarConfigureProxy.updatePreviousDateCalendar(),
                calendarConfigureProxy.updateNextMonthCalendar()
            )
            
        case let .changeCalendarStyle(style):
            switch style {
            case .bubble:
                return .concat([
                    calendarConfigureProxy.configureBubbleCalendar(),
                    calendarConfigureProxy.configureBubbleCalendarDay()
                ])
            case .default:
                return .concat([
                    calendarConfigureProxy.configureCalendar(),
                    calendarConfigureProxy.updateNextMonthCalendar()
                ])
            }
        }
        
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        switch mutation {
            
        case let .setCalendarItems(items):
            let calendarSectionIndex = self.getIndex(section: .calendar([]))
            newState.section[calendarSectionIndex] = .calendar(items)
        case let .setUpdateMonthItem(nextMonth):
            newState.month = nextMonth
            
            return newState
        case let .updateCalendarStyle(style):
            
            newState.style = style
            
        case let .setBubbleCalendarDay(nowDay):
            newState.nowDay = nowDay
        }
        
        return newState
    }
    
}



private extension HPCalendarViewReactor {
    
    func getIndex(section: CalendarSection) -> Int {
        var index: Int = 0
        
        for i in 0 ..< self.currentState.section.count where self.currentState.section[i].getSectionType() == section.getSectionType() {
            index = i
        }
        
        return index
        
    }
    
}



public enum HPCalendarState {
    case previous
    case next
    case now
}



public protocol HPCalendarInterface {
    var nowDate: Date { get set }
    var calendarState: HPCalendarState { get set }
}

public protocol HPCalendarBubbleDelegateProxy {
    func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func configureBubbleCalendarDay() -> Observable<HPCalendarViewReactor.Mutation>
}


public protocol HPCalendarDelgateProxy  {
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func setConfigureDays(date: Date) -> Int
}


public final class HPCalendarProxyBinder: HPCalendarDelgateProxy, HPCalendarBubbleDelegateProxy, HPCalendarInterface {
    //MARK: Property
    public var nowDate: Date = Date()
    public var calendarState: HPCalendarState = .now
    
    
    //TODO: HPCalendar 과거 일경우 False 미래 혹은 현재 일경우 True 값으로 리턴하여 색상 변경
    
    public func configureBubbleCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        var alpha: CGFloat = 5
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
                            alpha: alpha + 10,
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
                            alpha: alpha + 10,
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

