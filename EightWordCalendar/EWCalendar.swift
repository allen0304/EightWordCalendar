//
//  EWCalendar.swift
//  PocketMaster
//
//  Created by Allen on 2015/9/9.
//  Copyright (c) 2015年 Allen. All rights reserved.
//
//  參考：
//  https://zh.wikipedia.org/wiki/甲子


import UIKit

// 1900 ~ 2100 農曆年大小閏月資料
let lunarInfo = [
    0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,    //1900 ~ 1909
    0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,    //1910
    0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,    //1920
    0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,    //1930
    0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,    //1940
    
    0x06ca0,0x0b550,0x15355,0x04da0,0x0a5b0,0x14573,0x052b0,0x0a9a8,0x0e950,0x06aa0,    //1950
    0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,    //1960
    0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b6a0,0x195a6,    //1970
    0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,    //1980
    0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,    //1990
    
    0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,    //2000
    0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,    //2010
    0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,    //2020
    0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,    //2030
    0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0,    //2040
    
    0x04b63,0x0937f,0x049f8,0x04970,0x064b0,0x068a6,0x0ea5f,0x06b20,0x0a6c4,0x0aaef,    //2050
    0x092e0,0x0d2e3,0x0c960,0x0d557,0x0d4a0,0x0da50,0x05d55,0x056a0,0x0a6d0,0x055d4,    //2060
    0x052d0,0x0a9b8,0x0a950,0x0b4a0,0x0b6a6,0x0ad50,0x055a0,0x0aba4,0x0a5b0,0x052b0,    //2070
    0x0b273,0x06930,0x07337,0x06aa0,0x0ad50,0x04b55,0x04b6f,0x0a570,0x054e4,0x0d260,    //2080
    0x0e968,0x0d520,0x0daa0,0x06aa6,0x056df,0x04ae0,0x0a9d4,0x0a4d0,0x0d150,0x0f252,    //2090
    0x0d520]                                                                            //2100

let 節氣表 = [
    "立春", "雨水", "驚蟄", "春分", "清明", "驚蟄",
    "立夏", "小滿", "芒種", "夏至", "小暑", "大暑",
    "立秋", "處暑", "白露", "秋分", "寒露", "霜降",
    "立冬", "小雪", "大雪", "冬至", "小寒", "大寒"]

enum 五行: Int {
    case 木 = 0, 火, 土, 金, 水
    
    var color: UIColor {
        switch self {
        case .木:
            return UIColor.greenColor()
        case .火:
            return UIColor.redColor()
        case .土:
            return UIColor.brownColor()
        case .金:
            return UIColor.orangeColor()
        case .水:
            return UIColor.blueColor()
        }
    }
}

enum 十神: Int {
    case 比肩 = 1
    case 劫財 = -1
    case 食神 = 2
    case 傷官 = -2
    case 偏財 = 3
    case 正財 = -3
    case 七殺 = 4
    case 正官 = -4
    case 偏印 = 5
    case 正印 = -5
    
    var shortName: String {
        switch self {
        case .比肩:
            return "比"
        case .劫財:
            return "劫"
        case .食神:
            return "食"
        case .傷官:
            return "傷"
        case .偏財:
            return "才"
        case .正財:
            return "財"
        case .七殺:
            return "殺"
        case .正官:
            return "官"
        case .偏印:
            return "P"
        case .正印:
            return "印"
        }
    }
    
    var verticalName: String {
        switch self {
        case .比肩:
            return "比\n肩"
        case .劫財:
            return "劫\n財"
        case .食神:
            return "食\n神"
        case .傷官:
            return "傷\n官"
        case .偏財:
            return "偏\n財"
        case .正財:
            return "正\n財"
        case .七殺:
            return "七\n殺"
        case .正官:
            return "正\n官"
        case .偏印:
            return "偏\n印"
        case .正印:
            return "正\n印"
        }
    }
}

enum 天干: Int {
    case 甲 = 0, 乙, 丙, 丁, 戊, 己, 庚, 辛, 壬, 癸
    
    var element: 五行 {
        switch self {
        case .甲, .乙:
            return .木
        case .丙, .丁:
            return .火
        case .戊, .己:
            return .土
        case .庚, .辛:
            return .金
        case .壬, .癸:
            return .水
        }
    }
    
    var biValue: Int {
        switch self {
        case .甲, .丙, .戊, .庚, .壬:
            return 1
        case .乙, .丁, .己, .辛, .癸:
            return -1
            
        }
    }
}

enum 地支: Int {
    case 子 = 0, 丑, 寅, 卯, 辰, 巳, 午, 未, 申, 酉, 戌, 亥
    
    var element: 五行 {
        switch self {
        case .寅, .卯:
            return .木
        case .巳, .午:
            return .火
        case .申, .酉:
            return .金
        case .亥, .子:
            return .水
        case .辰, .未, .戌, .丑:
            return .土
        }
    }
    
    var 生肖: String {
        switch self {
        case .子:
            return "鼠"
        case .丑:
            return "牛"
        case .寅:
            return "虎"
        case .卯:
            return "兔"
        case .辰:
            return "龍"
        case .巳:
            return "蛇"
        case .午:
            return "馬"
        case .未:
            return "羊"
        case .申:
            return "猴"
        case .酉:
            return "雞"
        case .戌:
            return "狗"
        case .亥:
            return "豬"
        }
    }
    
    var 藏干: [天干] {
        switch self {
        case .子:
            return [.癸]
        case .丑:
            return [.己, .癸, .辛]
        case .寅:
            return [.甲, .丙, .戊]
        case .卯:
            return [.乙]
        case .辰:
            return [.戊, .乙, .癸]
        case .巳:
            return [.丙, .戊, .庚]
        case .午:
            return [.丁, .己]
        case .未:
            return [.己, .丁, .乙]
        case .申:
            return [.庚, .壬, .戊]
        case .酉:
            return [.辛]
        case .戌:
            return [.戊, .辛, .丁]
        case .亥:
            return [.壬, .甲]
        }
    }
}


let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!  // 西曆
let chineseCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierChinese)!       // 農曆
let rocCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierRepublicOfChina)!   // 國曆

struct SolarTerm {
    var termName: String
    var termDate: NSDate
}

struct EWCalendar {
    var theDate: NSDate {
        didSet {
            year = gregorianCalendar.component(NSCalendarUnit.Year, fromDate: theDate)
            month = gregorianCalendar.component(NSCalendarUnit.Month, fromDate: theDate)
            day = gregorianCalendar.component(NSCalendarUnit.Day, fromDate: theDate)
            solarTerms = computeSolarTerm(month)
        }
    }
    var year: Int
    var month: Int
    var day: Int
    var solarTerms = [SolarTerm]()   // 當月節氣
    var fmt = NSDateFormatter()
    
    init() {
        theDate = NSDate()
        fmt.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX")
        fmt.calendar = gregorianCalendar
        year = gregorianCalendar.component(NSCalendarUnit.Year, fromDate: theDate)
        month = gregorianCalendar.component(NSCalendarUnit.Month, fromDate: theDate)
        day = gregorianCalendar.component(NSCalendarUnit.Day, fromDate: theDate)
        solarTerms = computeSolarTerm(month)
    }
    
    init(aDate: NSDate) {
        theDate = aDate
        fmt.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX")
        fmt.calendar = gregorianCalendar
        year = gregorianCalendar.component(NSCalendarUnit.Year, fromDate: theDate)
        month = gregorianCalendar.component(NSCalendarUnit.Month, fromDate: theDate)
        day = gregorianCalendar.component(NSCalendarUnit.Day, fromDate: theDate)
        solarTerms = computeSolarTerm(month)
    }
    
    mutating func setDate(aDate: NSDate) {
        self.theDate = aDate
    }
    
    // 西元4年為甲子年起算，以節氣轉換調整
    var 年干: 天干 {
        var index = (year - 4) % 10
        if month == 1 {
            if index == 0 {
                index = 9
            } else {
                index--
            }
            
        } else if month == 2 {
            let calendarUnit = NSCalendarUnit.Minute
            let dateCompare: NSComparisonResult = gregorianCalendar.compareDate(theDate, toDate: solarTerms[0].termDate, toUnitGranularity: calendarUnit)
            if  dateCompare == .OrderedAscending {
                if index == 0 {
                    index = 9
                } else {
                    index--
                }
            }
        }
        return 天干(rawValue: index)!
    }
    
    var 年支: 地支 {
        var index = (year - 4) % 12
        if month == 1 {
            if index == 0 {
                index = 11
            } else {
                index--
            }
        } else if month == 2 {
            let calendarUnit = NSCalendarUnit.Minute
            let dateCompare: NSComparisonResult = gregorianCalendar.compareDate(theDate, toDate: solarTerms[0].termDate, toUnitGranularity: calendarUnit)
            if  dateCompare == .OrderedAscending {
                if index == 0 {
                    index = 11
                } else {
                    index--
                }
            }
        }
        return 地支(rawValue: index)!
    }
    
    var 生肖: String {
        return 年支.生肖
    }
    
    // 以年干和月支求月干
    var 月干: 天干 {
        let yearIndex = 年干.rawValue % 5 //find(天干表, 年干)! % 5
        var monthIndex = 月支.rawValue //find(地支表, 月支)!
        if monthIndex == 0 || monthIndex == 1 {
            monthIndex += 12
        }
        let index = (yearIndex * 2 + monthIndex) % 10
        return 天干(rawValue: index)!
    }
    
    // 以節氣轉換為準
    var 月支: 地支 {
        var index: Int = month % 12
        let calendarUnit = NSCalendarUnit.Minute
        let dateCompare: NSComparisonResult = gregorianCalendar.compareDate(theDate, toDate: solarTerms[0].termDate, toUnitGranularity: calendarUnit)
        if  dateCompare == .OrderedAscending {
            if index == 0 {
                index = 11
            } else {
                index--
            }
        }
        return 地支(rawValue: index)!
    }
    
    var 日干: 天干 {
        let start = "1921-01-01"    // 甲子日起算
        fmt.calendar = gregorianCalendar
        fmt.dateFormat = "yyyy-MM-dd"
        let startDate = fmt.dateFromString(start)
        let calendarUnit = NSCalendarUnit.Day
        let comps = gregorianCalendar.components(calendarUnit, fromDate: startDate!, toDate: theDate, options: [])
        let index = comps.day % 10
        return 天干(rawValue: index)!
    }
    
    var 日支: 地支 {
        let start = "1921-01-01"  // 甲子日起算
        fmt.calendar = gregorianCalendar
        fmt.dateFormat = "yyyy-MM-dd"
        let startDate = fmt.dateFromString(start)
        let calendarUnit = NSCalendarUnit.Day
        let comps = gregorianCalendar.components(calendarUnit, fromDate: startDate!, toDate: theDate, options: [])
        let index = comps.day % 12
        return 地支(rawValue: index)!
    }
    
    // 採子正(0時)換日法，從日干轉換
    var 時干: 天干 {
        let dayIndex = 日干.rawValue % 5  //find(天干表, 日干)! % 5
        let hourIndex = 時支.rawValue
        let index: Int = ((dayIndex * 2) + hourIndex) % 10
        return 天干(rawValue: index)!
    }
    
    var 時支: 地支 {
        let calendarUnit = NSCalendarUnit.Hour
        let hour = gregorianCalendar.component(calendarUnit, fromDate: theDate)
        let index: Int = ((hour == 23 ? 0 : hour) + 1) / 2
        return 地支(rawValue: index)!
    }
    
    // 十神
    func getTenGod(aBranch: 天干) -> String {
        let x: Int = 日干.element.rawValue
        let y: Int = aBranch.element.rawValue
        let b: Int = 日干.biValue * aBranch.biValue
        var index = (4 * x + y) % 5 + 1
        index *= b
        return String(十神(rawValue: index)!)
    }
    
    func getTenGodForVerticalName(aBranch: 天干) -> String {
        let x: Int = 日干.element.rawValue
        let y: Int = aBranch.element.rawValue
        let b: Int = 日干.biValue * aBranch.biValue
        var index = (4 * x + y) % 5 + 1
        index *= b
        return 十神(rawValue: index)!.verticalName
    }
    
    func getTenGodForShortName(aBranch: 天干) -> String {
        let x: Int = 日干.element.rawValue
        let y: Int = aBranch.element.rawValue
        let b: Int = 日干.biValue * aBranch.biValue
        var index = (4 * x + y) % 5 + 1
        index *= b
        return 十神(rawValue: index)!.shortName
    }
    
    // 國曆
    var rocDateString: String {
        fmt.calendar = rocCalendar
        fmt.dateStyle = NSDateFormatterStyle.FullStyle
        //fmt.dateFormat = "（Gy）u 年 M 月 d 日 EEEE"
        fmt.dateFormat = "u 年 M 月 d 日 EEEE"
        return fmt.stringFromDate(theDate)
    }
    
    // 農曆
    var lunarDateString: String {
        fmt.calendar = chineseCalendar
        fmt.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX")
        fmt.dateStyle = NSDateFormatterStyle.FullStyle
        fmt.dateFormat = "\(年干)\(年支)年 LLLL dd"
        return fmt.stringFromDate(theDate)
    }
    
    // 返回該年月的天數
    func monthDays(year y: Int, month m: Int) -> Int {
        return  (((lunarInfo[y - 1900] & (0x10000 >> m)) != 0) ? 30 : 29)
    }
    
    // 該年閏月
    func doubleMonth(year y: Int) -> Int {
        return (lunarInfo[y - 1900] & 0xf)
    }
    
    // 該年閏月天數
    func doubleMonthDays(year y: Int) -> Int {
        if doubleMonth(year: y) != 0 {
            return  (((lunarInfo[y - 1900] & 0x10000) != 0) ? 30 : 29)
        } else {
            return 0
        }
    }
    
    // 計算當月節氣日期
    private func computeSolarTerm(month: Int) -> [SolarTerm] {
        var aArray = [SolarTerm]()
        for var n = (month * 2 - 1); n <= month * 2; n++ {
            let termDays = term(year, n: n, pd: true)
            let mdays = antiDayDifference(year, d: Int(termDays))
            let termDay: Int = mdays % 100
            let hour: Int = Int(tail(termDays) * 24)
            let minute: Int = Int((tail(termDays) * 24 - Double(hour)) * 60)
            
            let dateComponents = NSDateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = termDay
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let termDate = gregorianCalendar.dateFromComponents(dateComponents)
            
            if n < 3 {
                aArray.append(SolarTerm(termName: 節氣表[n + 21], termDate: termDate!))
            } else {
                aArray.append(SolarTerm(termName: 節氣表[n - 3], termDate: termDate!))
            }
        }
        return aArray
    }
    
    private func tail(x: Double) -> Double {
        return x - floor(x)
    }
    
    private func term(y: Int, n: Int, pd: Bool) -> Double {
        // 儒略日
        var juD: Double = 365.2423112
        juD -=  6.4e-14 * Double(y - 100) * Double(y - 100)
        juD -= 3.047e-8 * Double(y - 100)
        juD *= Double(y)
        juD += 15.218427 * Double(n) + 1721050.71301
        
        // 角度
        let tht: Double = 3e-4 * Double(y) - 0.372781384 - 0.2617913325 * Double(n)
        
        //年差实均数
        var yrD: Double = (1.945 * sin(tht) - 0.01206 * sin(2 * tht))
        yrD *= (1.048994 - 2.583e-5 * Double(y))
        
        //朔差实均数
        let shuoD: Double = -18e-4 * sin(2.313908653 * Double(y) - 0.439822951 - 3.0443 * Double(n))
        
        let vs: Double = pd ? (juD + yrD + shuoD - Double(equivalentStandardDay(y, m: 1, d: 0)) - 1721425) : (juD - Double(equivalentStandardDay(y, m: 1, d: 0)) - 1721425)
        return vs
    }
    
    private func antiDayDifference(y: Int, d: Int) -> Int {
        var x = d
        var m = 1
        
        for var j = 1; j <= 12; j++ {
            let mL = dayDifference(y, m: (j+1), d: 1) - dayDifference(y, m: j, d: 1)
            if ((x <= mL) || j == 12) {
                m = j
                break
            } else {
                x = x - mL
            }
        }
        return 100 * m + x
    }
    
    private func equivalentStandardDay(y: Int, m: Int, d: Int) -> Int {
        //Julian的等效标准天数
        var v: Int = (y - 1) * 365 + Int((y - 1) / 4)
        v += dayDifference(y, m: m, d: d) - 2
        
        //Gregorian的等效标准天数
        if (y > 1582) {
            v += -((y - 1) / 100) + Int((y - 1) / 400)
            v += 2
        }
        return v;
    }
    
    private func dayDifference(y: Int, m: Int, d: Int) -> Int {
        var monL = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let ifG = ifGregorian(y, m: m, d: d, option: 1)
        if ifG == 1 {
            if ((y % 100 != 0 && y % 4 == 0) || (y % 400 == 0)) {
                monL[2] += 1
            } else {
                if (y % 4 == 0) { monL[2] += 1 }
            }
        }
        
        var v = 0
        for var i = 0; i <= (m - 1); i++ {
            v += monL[i]
        }
        v += d
        
        // 換曆年 天數修正
        if (y == 1582) {
            if ifG == 1 { v -= 10 }
            if ifG == -1 { v = 0 }      // 1582/10/5 ~ 10/14 日期無效
        }
        
        return v
    }
    
    private func ifGregorian(y: Int, m: Int, d: Int, option: Int) -> Int {
        if (option == 1)
        {
            if (y > 1582 || (y == 1582 && m > 10) || (y == 1582 && m == 10 && d > 14)) {
                return (1);	 //Gregorian
            } else {
                if (y == 1582 && m == 10 && d >= 5 && d <= 14) {
                    return (-1);  //空
                } else {
                    return (0);  //Julian
                }
            }
        }
        
        if (option == 2) {
            return (1);	 //Gregorian
        }
        
        if (option == 3) {
            return (0);	 //Julian
        }
        return (-1);
    }

}