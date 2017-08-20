//
//  CalendarDayInfo.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import Foundation

class CalendarDayInfo: NSObject {
    var date: CVDate
    var subText: String        //底部的文字
    var dayStatus: DayStatus
    var restStatus: RestStatus
    var weekDay: CVCalendarWeekday
    
    init(date: CVDate, subText: String, restStatus: RestStatus) {
        self.date = date
        self.subText = subText
        
        self.restStatus = restStatus
        self.dayStatus = .in
        self.weekDay = .friday
    }
}

enum DayStatus: Int {
    case `in`, out, disable
}

enum RestStatus: Int {
    case rest, work, common
}

enum SubTitleType: Int {
    case lunar //农历
    case festival
    case sanfu
    case solarTerm //二十四节气
}
