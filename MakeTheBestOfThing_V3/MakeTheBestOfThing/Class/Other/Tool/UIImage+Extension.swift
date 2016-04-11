//
//  UIImage+Extension.swift
//  PinGo
//
//  Created by Qinting on 16/3/25.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     根据颜色和尺寸 生成一张图片
     
     - parameter color: 颜色
     - parameter size:  尺寸
     
     - returns: 返回一张图片
     */
    class func imageWithColor(color:UIColor,size:CGSize) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(
        CGSizeMake(size.width, size.height), true, UIScreen.mainScreen().scale)
        color.set()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}