//
//  UIImageExtensions.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/6/2.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

enum ImageName: String {
    case calendarToday = "calendar_img_today"
    case calendarSelect = "calendar_icon_tools_null"
}

extension UIImage {
    convenience init!(imageName: ImageName) {
        self.init(named: imageName.rawValue)
    }
}
