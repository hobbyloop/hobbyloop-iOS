//
//  HPCalendarInterface.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation


public enum HPCalendarState {
    case previous
    case next
    case now
}


public enum CalendarStyle {
    case `default`
    case bubble
}


public protocol HPCalendarInterface {
    var nowDate: Date { get set }
    var calendarState: HPCalendarState { get set }
}
