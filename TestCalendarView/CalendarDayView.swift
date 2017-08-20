//
//  CalendarDayView.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

class CalendarDayView: UIControl {
    fileprivate var dayLabel: UILabel!
    fileprivate var subLabel: UILabel!
    fileprivate var todayIcon: UIImageView!
    
    
    var date: CalendarDate? {
        guard let dayInfo = dayInfo else {
            return nil
        }
        return dayInfo.date
    }
    
    var isToday: Bool {
        guard let dayInfo = dayInfo else {
            return false
        }
        
        return dayInfo.date.isToday
    }
    
    var dayInfo: CalendarDayInfo? {
        didSet {
            guard let dayInfo = dayInfo, dayInfo.date != oldValue?.date else {
                return
            }
            
            dayLabel.text = String(dayInfo.date.day)
            subLabel.text = dayInfo.subTitle
            
            dayLabel.textColor = CalendarViewAppearance.dayLabelColor(by: dayInfo.weekday, status: dayInfo.dayStatus)
            subLabel.textColor = CalendarViewAppearance.subLabelColor(by: dayInfo.dayStatus, subTitle: dayInfo.subTitleType)
            
            if dayInfo.date.isToday {
                todayIcon.isHidden = false
                todayIcon.alpha = dayInfo.isOut ? 0.45 : 1.0
            } else {
                todayIcon.isHidden = true
            }

            isUserInteractionEnabled = (dayInfo.dayStatus != .disabled)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.clear
        
        dayLabel = UILabel()
        dayLabel.textAlignment = .center
        dayLabel.font = CalendarViewAppearance.dayLabelFont
        addSubview(dayLabel)
        
        subLabel = UILabel()
        subLabel.textAlignment = .center
        subLabel.font = CalendarViewAppearance.subLabelFont
        addSubview(subLabel)
        
        todayIcon = UIImageView()
        todayIcon.image = CalendarViewAppearance.todayImage
        todayIcon.isHidden = true
        insertSubview(todayIcon, at: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = bounds.height
        
        let daySize = CalendarViewAppearance.dayLabelFontSize
        let subSize = CalendarViewAppearance.subLabelFontSize
        
        var Y = (height - daySize - 2.0 - subSize) / 2
        dayLabel?.frame = CGRect(x: 0.0, y: Y, width: bounds.width, height: daySize)
        
        Y = Y + daySize + 2.0
        subLabel.frame = CGRect(x: 0.0, y: Y, width: bounds.width, height: subSize)
        
        let side = min(bounds.width, bounds.height)
        todayIcon.frame = CGRect(x: (bounds.width - side)/2.0, y: (bounds.height - side)/2.0, width: side, height: side)
        
        super.layoutSubviews()
    }
}
