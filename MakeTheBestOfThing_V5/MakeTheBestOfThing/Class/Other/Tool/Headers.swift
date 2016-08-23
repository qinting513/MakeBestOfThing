//
//  Headers.swift
//  PinGo
//
//  Created by Qinting on 16/3/25.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation
import UIKit

let iOS9Later              = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 9.0
let iPhone4s               = (UIScreen.mainScreen().bounds.size.width == 320)
let kNaviBarHeight:CGFloat = 64.0
let kTabBarHeight:CGFloat  = 49.0
let kScreenWidth           = UIScreen.mainScreen().bounds.width
let kScreenHeight          = UIScreen.mainScreen().bounds.height

/// 统一的外观颜色
let kAppearanceColor       = UIColor.colorWithRGBA(250, G: 60, B: 67)
/// 主要的字体
let kMainFont              = UIFont.systemFontOfSize(15.0)
let kNavigationBarFont     = UIFont.systemFontOfSize(16.0)

let kCalendar               = NSCalendar.currentCalendar()
let kDateFormatter         = NSDateFormatter()

enum QueryMethod{
    case New  //获取最新的数据
    case Old // 获取旧数据
}