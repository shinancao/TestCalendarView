//
//  CalendarWeekView.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import UIKit

class CalendarWeekView: UIView {
    
    var dayViews: [CalendarDayView]!
    
    init() {
        super.init(frame: .zero)
        
        createDayViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutDayViews()
        
        super.layoutSubviews()
    }
    
    func mapDayViews(_ body: (CalendarDayView) -> ()) {
        if let dayViews = dayViews {
            for dayView in dayViews {
                body(dayView)
            }
        }
    }
}

// MARK: - Content fill & reload
extension CalendarWeekView {
    func createDayViews() {
        dayViews = [CalendarDayView]()
        for _ in 1...7 {
            let dayView = CalendarDayView()
            dayViews.append(dayView)
            addSubview(dayView)
        }
    }
    
    func layoutDayViews() {
        let height = bounds.height
        let width = bounds.width / 7.0
        for (index, dayView) in dayViews.enumerated() {
            let x = CGFloat(index) * CGFloat(width)
            dayView.frame = CGRect(x: x, y: 0, width: width, height: height)
        }
    }
}

