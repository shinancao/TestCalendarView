//
//  CalendarViewBehavior.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/6/5.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import Foundation

struct CalendarViewBehavior {
    static let starterWeekday: Int = CalendarWeekday.sunday.rawValue
    
    static let earliestSelectableDate: CalendarDate? = CalendarDate(day: 1, month: 1, week: 1, year: 1901) //1901
    
    static let latestSelectableDate: CalendarDate? = CalendarDate(day: 31, month: 12, week: 1, year: 2099)
}
