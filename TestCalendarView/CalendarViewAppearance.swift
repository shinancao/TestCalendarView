//
//  CalendarViewAppearance.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

struct CalendarViewAppearance {
    struct Color {
        static let text = AppColor.black
        static let textOutMonth = AppColor.black.withAlphaComponent(0.45)
        static let weekendsInMonthText = AppColor.orange
        static let weekendsOutMonthText = AppColor.orange.withAlphaComponent(0.45)
        static let lunarText = AppColor.gray
        static let lunarTextOutMonth = AppColor.gray.withAlphaComponent(0.45)
        static let specialText = AppColor.orange
        static let specialTextOutMonth = AppColor.gray.withAlphaComponent(0.45)
    }
    
    static func dayLabelColor(by weekDay: CalendarWeekday, status: DayStatus) -> UIColor {
        switch (weekDay, status) {
        case (.sunday, .out), (.saturday, .out): return Color.weekendsOutMonthText
        case (.sunday, .in), (.saturday, .in): return Color.weekendsInMonthText
        case (_, .out), (_, .disabled): return Color.textOutMonth
        default: return Color.text
        }
    }
    
    static func subLabelColor(by status: DayStatus, subTitle: SubTitleType) -> UIColor {
        switch (subTitle, status) {
        case (.lunar, .in): return Color.lunarText
        case (.lunar, .out): return Color.lunarTextOutMonth
        case (_, .in): return Color.specialText
        case (_, .out): return Color.specialTextOutMonth
        default: return Color.lunarText
        }
    }
    
    static let dayLabelFontSize: CGFloat = 21.0
    static let subLabelFontSize: CGFloat = 11.0
    
    static var dayLabelFont: UIFont {
        return UIFont.systemFont(ofSize: dayLabelFontSize)
    }
    
    static var subLabelFont: UIFont {
        return UIFont.systemFont(ofSize: subLabelFontSize)
    }
    
    static var todayImage: UIImage {
        return UIImage(imageName: .calendarToday)
    }
    
    static var selectedImage: UIImage {
        return UIImage(imageName: .calendarSelect)
    }
}
