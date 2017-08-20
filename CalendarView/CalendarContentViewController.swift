//
//  CalendarContentViewController.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 2345.com. All rights reserved.
//

import UIKit

class CalendarContentViewController: UIViewController {
    
    let calendarView: AACalendarView
    let scrollView: UIScrollView
    
    var leftMonthView: CalendarMonthView!
    var centerMonthView: CalendarMonthView!
    var rightMonthView: CalendarMonthView!
    
    var bounds: CGRect {
        return scrollView.bounds
    }
    
    init(calendarView: AACalendarView, frame: CGRect) {
        self.calendarView = calendarView
        scrollView = UIScrollView(frame: frame)
        
        super.init(nibName: nil, bundle: nil)
        
        scrollView.contentSize = CGSize(width: frame.width * 3, height: frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        
        createMonthViews()
        
        layoutMonthViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CalendarContentViewController {
    func createMonthViews() {
        leftMonthView = CalendarMonthView()
        scrollView.addSubview(leftMonthView)
        
        centerMonthView = CalendarMonthView()
        scrollView.addSubview(centerMonthView)
        
        rightMonthView = CalendarMonthView()
        scrollView.addSubview(rightMonthView)
    }
    
    func layoutMonthViews() {
        leftMonthView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        centerMonthView.frame = CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height)
        rightMonthView.frame = CGRect(x: bounds.width * 2, y: 0, width: bounds.width, height: bounds.height)
    }
}

extension CalendarContentViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            //计算月份
        } else if scrollView.contentOffset.x == bounds.width * 2 {
        
        } else {
            return
        }
        
        self.scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)
    }
}
