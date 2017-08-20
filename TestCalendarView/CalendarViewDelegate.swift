//
//  CalendarViewDelegate.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/5/30.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

@objc protocol CalendarViewDelegate {
    @objc optional func calendarViewHeightDidChange()
    @objc optional func calendarViewDidSelectDate(_ date: CalendarDate)
    @objc optional func calendarViewFinishSelectDate(_ date: CalendarDate)
}
