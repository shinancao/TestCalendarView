//
//  CalendarMonthInfo.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import UIKit

class CalendarMonthInfo: NSObject {
    var date: Foundation.Date!
    var numberOfWeeks: Int!
    
    var allowScrollToPreviousMonth = true
    var allowScrollToNextMonth = true
}
