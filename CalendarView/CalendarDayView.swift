//
//  CalendarDayView.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import UIKit

class CalendarDayView: UIControl {
    private let dayLabelFontSize: CGFloat = 21.0
    private let subLabelFontSize: CGFloat = 11.0
    
    fileprivate var dayLabel: UILabel!
    fileprivate var subLabel: UILabel!
    
    
    var dayInfo: CalendarDayInfo? {
        didSet {
            guard let dayInfo = dayInfo, dayInfo.date != oldValue?.date else {
                return
            }
            
            dayLabel.text = String(dayInfo.date.day)
            subLabel.text = dayInfo.subText
            
            //TODO: 设置颜色
            dayLabel.textColor = CalendarAppearance.dayLabelColor(by: .monday, status: .in)
            subLabel.textColor = CalendarAppearance.subLabelColor(by: .in, subTitle: .lunar)
            
            isUserInteractionEnabled = (dayInfo.dayStatus != .disable)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        dayLabel = UILabel()
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont(name: "Nobel-Regular", size: dayLabelFontSize)!
        addSubview(dayLabel)
        
        subLabel = UILabel()
        subLabel.textAlignment = .center
        subLabel.font = UIFont.systemFont(ofSize: subLabelFontSize)
        addSubview(subLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = bounds.height
        
        var Y = (height - dayLabelFontSize - 2.0 - subLabelFontSize) / 2
        dayLabel?.frame = CGRect(x: 0.0, y: Y, width: bounds.width, height: dayLabelFontSize)
        
        Y = Y + dayLabelFontSize + 2.0
        subLabel.frame = CGRect(x: 0.0, y: Y, width: bounds.width, height: subLabelFontSize)
        
        super.layoutSubviews()
    }
}
