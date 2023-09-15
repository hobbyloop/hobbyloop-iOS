//
//  HPCalendarViewReactor.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/08/20.
//

import Foundation

import HPFoundation
import ReactorKit
import RxSwift


public final class HPCalendarViewReactor: Reactor {
    
    //MARK: Property
    public var initialState: State
    private var calendarConfigureProxy: HPCalendarDelgateProxy = HPCalendarProxyBinder()
    
    
    //MARK: Action
    public enum Action {
        case loadView
        case didTapNextDateButton
        case didTapPreviousDateButton
    }
    
    //MARK: Mutation
    public enum Mutation {
        case setCalendarItems([CalendarSectionItem])
        case setUpdateMonthItem(String)
    }
    
    //MARK: State
    public struct State {
        var days: [String]
        var month: String
        @Pulse var section: [CalendarSection]
    }
    
    
    public init() {
        self.initialState = State(
            days: [],
            month: "",
            section: [
                .calendar([])
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
            
        case .loadView:
            return .concat(
                calendarConfigureProxy.configureCalendar(),
                calendarConfigureProxy.updateNextMonthCalendar()
            )
            
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
        }
        
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        switch mutation {
            
        case let .setCalendarItems(items):
            let calendarSectionIndex = self.getIndex(section: .calendar([]))
            newState.section[calendarSectionIndex] = .calendar(items)
            return newState
            
        case let .setUpdateMonthItem(nextMonth):
            newState.month = nextMonth
            
            return newState
        }
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



enum HPCalendarState {
    case previous
    case next
    case now
}

protocol HPCalendarDelgateProxy {
    var nowDate: Date { get set }
    var calendarState: HPCalendarState { get set }
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation>
    func setConfigureDays(date: Date) -> Int
}


final class HPCalendarProxyBinder: HPCalendarDelgateProxy {
    
    //MARK: Property
    var nowDate: Date = Date()
    var calendarState: HPCalendarState = .now
    
    
    //TODO: HPCalendar 과거 일경우 False 미래 혹은 현재 일경우 True 값으로 리턴하여 색상 변경
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .now)
        
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        for days in Int() ..< totalDays {
            if days < startOfDays {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), iscompare: false)))
                continue
            }
            
            //TODO: 년,월,일 Compare 로직 부분 분기 처리 고민후 수정
            if Date().month == nowDate.month && days <= nowDate.day {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)", iscompare: false)))
            } else {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)", iscompare: true)))
            }
            
        }
        
        
        return .just(.setCalendarItems(calendarSectionItem))
    }
    
    
    func updateNextDateCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .next)
        var updateCalendarSectionItem: [CalendarSectionItem] = []
        var updateStartOfDays = (nowDate.weekday - 1)
        var updateTotalDays = updateStartOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< updateTotalDays {
            if days < updateStartOfDays {
                updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), iscompare: false)))
                continue
            }
            
            if Calendar.current.compare(Date(), to: nowDate, toGranularity: .month) == .orderedSame {
                if Date().month == nowDate.month && days <= nowDate.day {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", iscompare: false)))
                } else {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", iscompare: true)))
                }
            } else {
                if Date().dateCompare(fromDate: nowDate) {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", iscompare: true)))
                } else {
                    updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)", iscompare: false)))
                }
            }
        }
        
        
        return .just(.setCalendarItems(updateCalendarSectionItem))
    }
    
    
    func updatePreviousDateCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .previous)
        var previousCalendarSectionItem: [CalendarSectionItem] = []
        var previousStartOfDays = (nowDate.weekday - 1)
        var previousTotalDays = previousStartOfDays + setConfigureDays(date: nowDate)
        
        for days in Int() ..< previousTotalDays {
            
            if days < previousStartOfDays {
                previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String(), iscompare: false)))
                continue
            }
            
            if Calendar.current.compare(Date(), to: nowDate, toGranularity: .month) == .orderedSame {
                if Date().month == nowDate.month && days <= nowDate.day {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", iscompare: false)))
                } else {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", iscompare: true)))
                }
            } else {
                if Date().dateCompare(fromDate: nowDate) {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", iscompare: true)))
                } else {
                    previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)", iscompare: false)))
                }
            }

        }
        
        return .just(.setCalendarItems(previousCalendarSectionItem))
    }
    
    func updateNextMonthCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        
        return .just(.setUpdateMonthItem("\(self.nowDate.month)"))
    }
    
    func setConfigureDays(date: Date) -> Int {
        
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? Int()
    }
    
    
    func updateCalendarDate(state: HPCalendarState) {
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

