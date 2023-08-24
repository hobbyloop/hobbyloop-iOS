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
    }
    
    //MARK: Mutation
    public enum Mutation {
        case setCalendarItems
    }
    
    //MARK: State
    public struct State {
        var days: [String]
        @Pulse var section: [CalendarSection]
    }
    
    
    public init() {
        self.initialState = State(
            days: [],
            section: [
                calendarConfigureProxy.configureCalendar()
            ]
        )
    }
    
    
    public func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        switch mutation {
            
        case .setCalendarItems:
            
            return newState
        }
    }
    
}



protocol HPCalendarDelgateProxy {
    var nowDate: Date { get set }
    
    func configureCalendar() -> CalendarSection
}


final class HPCalendarProxyBinder: HPCalendarDelgateProxy {
    
    //MARK: Property
    var nowDate: Date = Date()
    
    
    
    
    func configureCalendar() -> CalendarSection {
        
        var calendarSectionItem: [CalendarSectionItem] = []
        var startOfDays = (nowDate.weekday - 1)
        var totalDays = startOfDays + nowDate.rangeOfdays
        for days in Int() ..< totalDays {
            if days < startOfDays {
                calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: String())))
                continue
            }
            calendarSectionItem.append(CalendarSectionItem.calendarItem(HPCalendarDayCellReactor(days: "\(days - startOfDays + 1)")))
        }
        
        return CalendarSection.calendar(calendarSectionItem)
    }
    
    
}

