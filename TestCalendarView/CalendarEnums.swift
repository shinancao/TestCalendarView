//
//  CalendarEnums.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/6/1.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import Foundation

public enum DayStatus: Int {
    case `in`, out, disabled
}

public enum RestStatus: Int {
    case rest, work, common
}

public enum SubTitleType: Int {
    case lunar //农历
    case festival
    case sanfu
    case solarTerm //二十四节气
}

public enum CalendarWeekday: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}
