//
//  UIColor+Extention.swift
//  PinGo
//
//  Created by Qinting on 16/3/25.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     创建颜色
     
     - parameter R: red
     - parameter G: green
     - parameter B: buew
     - parameter A: alpha
     
     - returns: 颜色
     class func 说明是类方法
     */
    class func colorWithRGBA(R:Float, G:Float, B:Float, A:Float = 1.0 )->UIColor{
    return UIColor(red: CGFloat(R / 255.0), green: CGFloat(G/255.0),
            blue: CGFloat(B/255.0), alpha: CGFloat(A))
    }
}