//
//  CalendarMonthView.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import UIKit

class CalendarMonthView: UIView {

    var weekViews: [CalendarWeekView]!
    
    var monthInfo: CalendarMonthInfo? {
        didSet {
            guard let monthInfo = monthInfo else {
                return
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        createWeekViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutWeekViews()
        
        super.layoutSubviews()
    }
    
    func mapDayViews(_ body: (CalendarDayView) -> ()) {
        for weekView in weekViews {
            for dayView in weekView.dayViews {
                body(dayView)
            }
        }
    }
}

extension CalendarMonthView {
    func createWeekViews() {
        for _ in 1...6 {
            let weekView = CalendarWeekView()
            weekViews.append(weekView)
            
            addSubview(weekView)
        }
    }
    
    func layoutWeekViews() {
        let height = bounds.height / 6.0 //总共都设置成6行，在5行时，hidden一行
        let width = bounds.width
        
        for (index, weekView) in weekViews.enumerated() {
            let y = CGFloat(index) * height
            weekView.frame = CGRect(x: 0, y: y, width: width, height: height)
        }
    }
}
