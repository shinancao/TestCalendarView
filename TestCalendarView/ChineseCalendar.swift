//
//  ChineseCalendar.swift
//  iOS_Calendar
//
//  Created by zhangnan on 2017/4/26.
//  Copyright © 2017年 zhangnan. All rights reserved.
//

import Foundation

private let lunarDays = ["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十","卅一"]

private let lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]

//lunarMonth在闰月时和非闰月时一样的值
func lunarMonthText(lunarMonth: Int, isLeap: Bool) -> String {
    
    if isLeap {
        return "闰" + lunarMonths[lunarMonth - 1]
    }
    
    return lunarMonths[lunarMonth - 1]
    
}

//农历日描述
func lunarDayText(withDay day: Int) -> String {
    guard day <= lunarDays.count else {
        fatalError()
    }
    return lunarDays[day - 1]
}


//MARK: 农历转公历

/**
 * 根据公历年月日,计算对应的农历日期
 * 以1900年1月31日为基准
 * @param year 公历年份
 * @param month 公历月份 [1-12]
 * @param day 公历日期
 * @return int[4]数组, [农历年份, 农历月份[1-12], 农历日期, 是否闰月(不等于0表示闰月)]
 */
func solarToLunarDate(solarYear: Int, solarMonth: Int, solarDay: Int) -> (Int, Int, Int, Bool) {

    let diff = UTC(solarYear, solarMonth, solarDay) - (-2206396800000) //UTC(1900,1,31)
    var offset = Int(round(Double(diff)/86400000.0))
    
    var temp = 0
    var i = 1900
    for _ in 1900 ..< 2100 {
        
        if offset <= 0 {
            break
        }
        
        temp = getDaysOfLunarYear(lunarYear: i)
        offset -= temp
        
        i += 1
 
    }
    
    if offset < 0 {
        offset += temp
        i -= 1
    }
    
    let year = i
    
    let leap = getLeapMonthInLunarYear(lunarYear: i) //闰哪个月
    var isLeap = false
    
    i = 1
    for _ in 1 ..< 13 {
        
        if offset <= 0 {
            break
        }
        
        //润月
        if leap > 0 && i == (leap + 1) && !isLeap {
            i -= 1
            isLeap = true
            temp = getLeapDaysInLunarYear(lunarYear: year)
        } else {
            temp = getDaysInLunarMonth(lunarYear: year, lunarMonth: i)
        }
        
        //解除闰月
        if isLeap && i == (leap + 1) {
            isLeap = false
        }
        
        offset -= temp
        
        i += 1
    }
    
    if offset == 0 && leap > 0 && i == leap+1 {
        if isLeap {
            isLeap = false
        } else {
            isLeap = true
            i -= 1
        }
    }
    
    if offset < 0 {
        offset += temp
        i -= 1
    }
    
    let month = i
    let day = offset + 1
    
    return (year, month, day, isLeap)
}


/// 农历转成公历日期
///
func lunarToSolarDate(lunarYear: Int, lunarMonth: Int, lunarDay: Int, isLeap: Bool) -> Date {
    let array: [Int] = Array(1900 ..< lunarYear)
    var offset = array.reduce(0) { (res, num) -> Int in
        return res + getDaysOfLunarYear(lunarYear: num)
    }
    
    let array2: [Int] = Array(1 ..< lunarMonth)
    let offset2 = array2.reduce(0) { (res, i) -> Int in
        var temp = res
        if i == getLeapMonthInLunarYear(lunarYear: lunarYear) {
            temp += getLeapDaysInLunarYear(lunarYear: lunarYear)
        }
        temp += getDaysInLunarMonth(lunarYear: lunarYear, lunarMonth: i)
        return temp
    }
    
    offset += offset2
    
    if isLeap {
        offset += getDaysInLunarMonth(lunarYear: lunarYear, lunarMonth: lunarMonth)
    }
    
    offset += (lunarDay - 1)
    let val = -2206425600 as Int64
    let interval = val + Int64(offset) * 86400
    return Date(timeIntervalSince1970: Double(interval))
}


/// 获取农历lunarYear年lunarMonth月的总天数
///
func getDaysInLunarMonth(lunarYear: Int, lunarMonth: Int) -> Int {
    var year = lunarYear
    if year < 1900 {
        year = 1900
    }
    return LUNAR_INFO[year - 1900] & (0x10000>>lunarMonth) > 0 ? 30 : 29
}


/// 返回农历lunarYear年润哪个月
///
/// - Parameter lunarYear: 农历年
/// - Returns: 如果没有闰月的时候，返回0
func getLeapMonthInLunarYear(lunarYear: Int) -> Int {
    var year = lunarYear
    if year < 1900 {
        year = 1900
    }
    
    let lm = LUNAR_INFO[year - 1900] & 0xf
    return lm == 0xf ? 0 : lm
}


/// 返回农历lunarYear年的润月的天数
///
func getLeapDaysInLunarYear(lunarYear: Int) -> Int {
    if getLeapMonthInLunarYear(lunarYear: lunarYear) > 0 {
        return LUNAR_INFO[lunarYear - 1899] & 0xf == 0xf ? 30 : 29
    } else {
        return 0
    }
}

/// 获取农历lunarYear年的总天数
///
func getDaysOfLunarYear(lunarYear: Int) -> Int {
    let index = lunarYear - 1900
    let days = LUNAR_YEAR[index]
    if days == 0 {
        let sum = sequence(first: 0x8000, next: { $0 >> 1 > 0x8 ? $0 >> 1 : nil}).reduce(348) { (res, num) -> Int in
            return res + ((LUNAR_INFO[index] & num) > 0 ? 1 : 0)
        }
        
        let res = sum + getLeapDaysInLunarYear(lunarYear: lunarYear)
        return res
    } else {
        return days
    }
}

func UTC(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 0, _ minute: Int = 0, _ second: Int = 0) -> Int64 {
    
    currentDateComps.year = year
    currentDateComps.month = month
    currentDateComps.day = day
    currentDateComps.hour = hour
    currentDateComps.minute = minute
    currentDateComps.second = second
    
    let date = gregorianCalendar.date(from: currentDateComps)!
    
    let nowDouble = date.timeIntervalSince1970
    
    return Int64(nowDouble * 1000)
}

// Warning: 如果修改LUNAR_INFO数组,请确保数组大小为201个
private let LUNAR_INFO = [
    0x4bd8,0x4ae0,0xa570,0x54d5,0xd260,0xd950,0x5554,0x56af,0x9ad0,0x55d2,0x4ae0,0xa5b6,0xa4d0,0xd250,0xd295,0xb54f,0xd6a0,0xada2,0x95b0,0x4977,
    0x497f,0xa4b0,0xb4b5,0x6a50,0x6d40,0xab54,0x2b6f,0x9570,0x52f2,0x4970,0x6566,0xd4a0,0xea50,0x6a95,0x5adf,0x2b60,0x86e3,0x92ef,0xc8d7,0xc95f,
    0xd4a0,0xd8a6,0xb55f,0x56a0,0xa5b4,0x25df,0x92d0,0xd2b2,0xa950,0xb557,0x6ca0,0xb550,0x5355,0x4daf,0xa5b0,0x4573,0x52bf,0xa9a8,0xe950,0x6aa0,
    0xaea6,0xab50,0x4b60,0xaae4,0xa570,0x5260,0xf263,0xd950,0x5b57,0x56a0,0x96d0,0x4dd5,0x4ad0,0xa4d0,0xd4d4,0xd250,0xd558,0xb540,0xb6a0,0x95a6,
    0x95bf,0x49b0,0xa974,0xa4b0,0xb27a,0x6a50,0x6d40,0xaf46,0xab60,0x9570,0x4af5,0x4970,0x64b0,0x74a3,0xea50,0x6b58,0x5ac0,0xab60,0x96d5,0x92e0,
    0xc960,0xd954,0xd4a0,0xda50,0x7552,0x56a0,0xabb7,0x25d0,0x92d0,0xcab5,0xa950,0xb4a0,0xbaa4,0xad50,0x55d9,0x4ba0,0xa5b0,0x5176,0x52bf,0xa930,
    0x7954,0x6aa0,0xad50,0x5b52,0x4b60,0xa6e6,0xa4e0,0xd260,0xea65,0xd530,0x5aa0,0x76a3,0x96d0,0x4afb,0x4ad0,0xa4d0,0xd0b6,0xd25f,0xd520,0xdd45,
    0xb5a0,0x56d0,0x55b2,0x49b0,0xa577,0xa4b0,0xaa50,0xb255,0x6d2f,0xada0,0x4b63,0x937f,0x49f8,0x4970,0x64b0,0x68a6,0xea5f,0x6b20,0xa6c4,0xaaef,
    0x92e0,0xd2e3,0xc960,0xd557,0xd4a0,0xda50,0x5d55,0x56a0,0xa6d0,0x55d4,0x52d0,0xa9b8,0xa950,0xb4a0,0xb6a6,0xad50,0x55a0,0xaba4,0xa5b0,0x52b0,
    0xb273,0x6930,0x7337,0x6aa0,0xad50,0x4b55,0x4b6f,0xa570,0x54e4,0xd260,0xe968,0xd520,0xdaa0,0x6aa6,0x56df,0x4ae0,0xa9d4,0xa4d0,0xd150,0xf252,
    0xd520
]

private let LUNAR_YEAR = [384,354,355,383,354,355,384,354,355,384,354,384,354,354,384,354,355,384,355,384,354,354,384,354,354,385,354,355,384,354,383,354,355,384,355,354,384,354,384,354,354,384,355,354,385,354,354,384,354,384,354,355,384,354,355,384,354,383,355,354,384,355,354,384,355,353,384,355,384,354,355,384,354,354,384,354,384,354,355,384,355,354,384,354,384,354,354,384,355,355,384,354,354,383,355,384,354,355,384,354,354,384,354,355,384,354,385,354,354,384,354,354,384,355,384,354,355,384,354,354,384,354,355,384,354,384,354,354,384,355,354,384,355,384,354,354,384,354,354,384,355,355,384,354,384,354,354,384,354,355,384,355,384,354,354,383,355,354,384,355,354,384,354,384,354,355,384,354,355,384,354,384,354,354,384,355,354,384,355,354,384,354,384,354,355,384,354,355,383,354,384,354,355,384,355,354,384,354,354,384,384,354]


