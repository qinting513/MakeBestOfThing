//
//  UIStoryboard+Extension.swift
//  PinGo
//
//  Created by Qinting on 16/3/25.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIStoryboard {

     /**
    
     根据storyboard 名称返回控制器
    
     - parameter name: storyboard名
     
     - returns: 控制器
     */
    class func initialViewController (name: String) ->UIViewController {
    let sb = UIStoryboard.init(name: name, bundle: nil)
        return sb.instantiateInitialViewController()!
    }

    /**
          根据storyboard 名称和标识符 返回控制器
     
     - parameter name:       storyboard名
     - parameter identifier: 标识符
     
     - returns: 控制器
     */
    class func initialViewController(name:String, identifier:String)->UIViewController{
    let sb = UIStoryboard.init(name: name, bundle: nil)
        return sb.instantiateViewControllerWithIdentifier(identifier)
    
    }
}
