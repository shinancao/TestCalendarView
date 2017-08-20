//
//  ViewController.swift
//  TestCalendarView
//
//  Created by zhangnan on 2017/5/29.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CalendarViewDelegate {

//    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var tableView: UITableView!
    
    var calendarCell: CalendarViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        calendarCell = tableView.dequeueReusableCell(withIdentifier: "CalendarViewCell") as! CalendarViewCell
        calendarCell.calendarView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarViewHeightDidChange() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func calendarViewDidSelectDate(_ date: CalendarDate) {
        print("select date: \(date.year)-\(date.month)-\(date.day)")
    }
    
    func calendarViewFinishSelectDate(_ date: CalendarDate) {
        print("FinishSelectDate: \(date.year)-\(date.month)-\(date.day)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return calendarCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return calendarCell.calendarView.height
    }
}

