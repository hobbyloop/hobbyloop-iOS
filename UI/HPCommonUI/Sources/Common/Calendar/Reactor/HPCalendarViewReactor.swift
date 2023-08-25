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
    
    
    
    func configureCalendar() -> Observable<HPCalendarViewReactor.Mutation> {
        updateCalendarDate(state: .now)
        
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + setConfigureDays(date: nowDate)
        for days in Int() ..< totalDays {
            if days < startOfDays {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String())))
                continue
            }
            calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)")))
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
                updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String())))
                continue
            }
            updateCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - updateStartOfDays + 1)")))
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
                previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String())))
                continue
            }
            previousCalendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - previousStartOfDays + 1)")))
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

