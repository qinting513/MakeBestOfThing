//
//  NSDate+Extension.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation

enum dateFormatSyle : String {
case Style1 = "yyyy-MM-dd"
}

extension NSDate {

    /**
    *  声明一个类方法，返回日期格式器
    */
    class func formatterWithStyle(withStyle style:dateFormatSyle) ->NSDateFormatter {
    let formatter = kDateFormatter
        formatter.dateFormat = style.rawValue
        formatter.locale = NSLocale.currentLocale()
        return formatter
    }
    
    /** 根据时间戳 返回日期 */
    class func dateWithTimeStamp(stamp : String) -> NSDate? {
        if let interval  = NSTimeInterval(stamp) {
        return NSDate(timeIntervalSince1970: interval)
        }
        return nil
    }
    
    /** 根据日期 返回字符串格式 */
    func string(withStyle style : dateFormatSyle) ->String? {
        switch style {
        case .Style1 :
            let formatter = NSDate.formatterWithStyle(withStyle: .Style1)
            return formatter.stringFromDate(self)
        }
    }
    
    /** 根据时间 判断是否是今年 */
    func isThisYear() -> Bool {
        let calendar = kCalendar
        let unit = NSCalendarUnit.Year
        
        let nowComponts = calendar.components(unit, fromDate: NSDate())
        let dCmps = calendar.components(unit, fromDate: self)
        return nowComponts.day == dCmps.day && nowComponts.month == dCmps.month && nowComponts.year == dCmps.year
    }
    
    /** 根据时间 判断是否是 昨天 */
    func isYestoday() ->Bool {
      return kCalendar.components(.Day, fromDate: self.dateFormat(), toDate: NSDate().dateFormat(), options: []).day == 1
    }
    
    func componentsDeltaWithNow() ->NSDateComponents {
    let calendar = kCalendar
        let unit : NSCalendarUnit = [.Day, .Hour, .Minute]
        return calendar.components(unit, fromDate: self, toDate: NSDate(), options: [])
    }
    
    
    /** 返回指定格式的日期 */
    private func dateFormat() ->NSDate {
        let format = NSDate.formatterWithStyle(withStyle: .Style1)
        let dateStr = format.stringFromDate(self)
        return format.dateFromString(dateStr)!
    }
}