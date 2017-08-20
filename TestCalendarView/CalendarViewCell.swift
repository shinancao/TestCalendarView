//
//  CalendarViewCell.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/5/30.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

class CalendarViewCell: UITableViewCell {

    @IBOutlet weak var calendarView: CalendarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
