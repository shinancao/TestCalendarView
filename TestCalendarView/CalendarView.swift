//
//  CalendarView.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    var contentController: CalendarContentViewController!
    weak var delegate: CalendarViewDelegate?
    var height: CGFloat = 0
    var today: Foundation.Date = Date()
    
    fileprivate lazy var selectionView: UIImageView = {
        let v = UIImageView(image: CalendarViewAppearance.selectedImage)
        v.frame = CGRect(x: 0, y: 0, width: 47, height: 47)
        self.insertSubview(v, at: 0)
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
}

extension CalendarView {
    
    func initialize() {
        contentController = CalendarContentViewController(calendarView: self, frame: bounds)
        addSubview(contentController.scrollView)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        contentController.updateLayoutIfNeeded()
        
        contentController.centerMonthView.mapDayViews { (dayView) in
            if dayView.isToday {
                self.selectDayView(dayView, animation: false, isHidden: true)
            }
        }
        
        delegate?.calendarViewDidSelectDate?(contentController.selectedDate)
    }
    
    func selectDayView(_ dayView: CalendarDayView, animation: Bool, isHidden: Bool) {
        var frame = selectionView.frame
        let rect = dayView.convert(dayView.frame, to: self)
        
        frame.origin.x = dayView.frame.origin.x + (rect.width - frame.width)/2.0
        frame.origin.y = rect.origin.y + (rect.height - frame.height)/2.0
        
        if animation {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.selectionView.frame = frame
                
            }){ [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.selectionView.isHidden = isHidden
            }
            
        } else {
            selectionView.frame = frame
            selectionView.isHidden = isHidden
        }
    }
}

// MARK: - Convenience API
extension CalendarView {
    
    //选择到某个日期
    func toggleViewWithDate(_ date: Foundation.Date) {
        contentController.togglePresentedDate(date)
    }
    
    func toggleCurrentDayView() {
        contentController.togglePresentedDate(today)
    }
    
    func refresh() {
        contentController.refresh()
    }
}


