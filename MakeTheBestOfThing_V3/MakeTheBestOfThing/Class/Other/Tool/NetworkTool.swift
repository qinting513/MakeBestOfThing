//
//  NetworkTool.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTool: NSObject {

    class func requestJSON(method:Alamofire.Method,URLString:String,parameters:[String:AnyObject]?=nil, completion:(response:  NetworkResponse?) ->() ){
                print(URLString)
        Alamofire.request( method,URLString, parameters:parameters,encoding: .URL,
            headers:nil).responseJSON
    {
        (JSON) ->Void in
        switch JSON.result
        {
                case .Success :
                    if let value = JSON.result.value
                    {
                        let nResponse = NetworkResponse(dict: value as! [String : AnyObject])
                        completion(response: nResponse)
                    }
                    
                case .Failure( let error):
                    debugPrint(error)
         }
    }
 }
    
}
