//
//  HPCalendarInterface.swift
//  HPCommonUI
//
//  Created by Kim dohyun on 2023/09/13.
//

import Foundation
/**
     하비루프  Monthly Calendar 월 단위를 계산하기 Enum Type 입니다.
 */
public enum HPCalendarState {
    /// 지난 달을 계산하기 위한 case 입니다.
    case previous
    /// 다음 달을 계산하기 위한 case 입니다.
    case next
    /// 현재 달을 계산하기 위한 case 입니다.
    case now
}

/**
     하비루프  Calendar Style을 지정하기 위한 열거형 Enum Type 입니다.
 */
public enum CalendarStyle {
    /// Montly Calnedar Style의  case 입니다.
    case `default`
    /// Weekly Calendar Style의 case 입니다.
    case bubble
}

/**
     하비루프  모든 Calendar Interface 구현하기 위한 Variable 값 입니다.
 */
public protocol HPCalendarInterface {
    var nowDate: Date { get set }
    var calendarState: HPCalendarState { get set }
}
