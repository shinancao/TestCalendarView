//
//  CalendarDate.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import Foundation

public class CalendarDate: NSObject {
    fileprivate let date: Foundation.Date
    
    public let year: Int
    public let month: Int
    public let week: Int
    public let day: Int
    
    public init(date: Foundation.Date, calendar: Calendar = Calendar.current) {
        let dateRange = Manager.dateRange(date, calendar: calendar)
        
        self.date = date
        self.year = dateRange.year
        self.month = dateRange.month
        self.week = dateRange.weekOfMonth
        self.day = dateRange.day
        
        super.init()
    }
    
    public init(day: Int, month: Int, week: Int, year: Int, calendar: Calendar = Calendar.current) {
        if let date = Manager.dateFromYear(year, month: month, week: week, day: day, calendar: calendar) {
            self.date = date
        } else {
            self.date = Foundation.Date()
        }
        
        self.year = year
        self.month = month
        self.week = week
        self.day = day
        
        super.init()
    }
}

extension CalendarDate {
    public func weekDay(calendar: Calendar = Calendar.current) -> CalendarWeekday? {
        let weekday = calendar.component(.weekday, from: date)
        return CalendarWeekday(rawValue: weekday)
    }
    
    public var isToday: Bool {
        let currentDateRange = Manager.dateRange(Date(), calendar: Calendar.current)
        return currentDateRange.day == self.day && currentDateRange.month == self.month && currentDateRange.year == self.year
    }
    
    public func compare(_ another: CalendarDate) -> ComparisonResult {
        if year < another.year {
            return .orderedAscending
        } else if year > another.year {
            return .orderedDescending
        } else {
            if month < another.month {
                return .orderedAscending
            } else if month > another.month {
                return .orderedDescending
            } else {
                if day < another.day {
                    return .orderedAscending
                } else if day > another.day {
                    return .orderedDescending
                } else {
                    return .orderedSame
                }
            }
        }
    }
    
    public func convertedDate(calendar: Calendar = Calendar.current) -> Foundation.Date? {
        var comps = Manager.componentsForDate(Foundation.Date(), calendar: calendar)
        
        comps.year = year
        comps.month = month
        comps.weekOfMonth = week
        comps.day = day
        
        return calendar.date(from: comps)
    }
}

public func matchedMonths(_ lhs: CalendarDate, _ rhs: CalendarDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month
}

public func matchedDays(_ lhs: CalendarDate, _ rhs: CalendarDate) -> Bool {
    return (lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day)
}
