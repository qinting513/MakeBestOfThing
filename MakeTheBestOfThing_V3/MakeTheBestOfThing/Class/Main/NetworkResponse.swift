//
//  NetworkResponse.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit


/** 
 
 选项形式（as?）的操作执行转换并返回期望类型的一个选项值，如果转换成功则返回的选项包含有效值，否则选项值为 nil 
  强制形式（as! ）的操作执行一个实例到目的类型的强制转换，因此使用该形式可能触发一个运行时错误。
 */

class NetworkResponse: NSObject {
    var codeMsg : String?
    var msg     : String?
    var rtn     : String?
    var data : [String:AnyObject]?
    
    init(dict:[String:AnyObject]){
    super.init()
        
        codeMsg = dict["codeMsg"] as? String
        msg = dict["msg"] as? String
        
        if let r = dict["rtn"] as? String {
            rtn = r;
        }else if let r = dict["rtn"] as? Int{
//        rtn = "\(rtn)"
            rtn = String(r)
        }
        
        data = dict["data"] as? [String:AnyObject]
    }
    
}
