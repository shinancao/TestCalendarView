//
//  CalendarAppearance.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import Foundation

struct CalendarAppearance {
//    struct Color {
//        static let text = UIColor(valueRGB: 0x222222)
//        static let textOutMonth = UIColor(valueRGB: 0x222222, alpha: 0.45)
//        static let weekendsInMonthText = AppColor.orange
//        static let weekendsOutMonthText = AppColor.orange.withAlphaComponent(0.45)
//        static let lunarText = AppColor.gray
//        static let lunarTextOutMonth = AppColor.gray.withAlphaComponent(0.45)
//        static let specialText = AppColor.orange
//        static let specialTextOutMonth = AppColor.gray.withAlphaComponent(0.45)
//        static let selectedBackgroundColor = UIColor(valueRGB: 0xe3e9ed)
//    }
    
    static func dayLabelColor(by weekDay: CVCalendarWeekday, status: DayStatus) -> UIColor {
        return AppColor.gray
    }
    
    static func subLabelColor(by status: DayStatus, subTitle: SubTitleType) -> UIColor {
        return AppColor.orange
    }
}
