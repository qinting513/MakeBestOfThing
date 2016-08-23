//
//  Banner.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

enum BannerQueryType {
     case Subject,Square
}

/** banner 旗帜 标语 */
class Banner: NSObject {

    var bannerID : String?
    var imageUrl : String?
    var jumpUrl  : String?
    
    /** 定义block */
    typealias bannerCompletion = (bannerList : [Banner]?) -> ()
    
    init(dict : [String : AnyObject]?){
    super.init()
        guard dict?.count > 0 else{
        return
        }
     setValuesForKeysWithDictionary(dict!)
    }

    /** 获取网络请求的数据 */
    class func fetchBannerList( type type : BannerQueryType,completion : bannerCompletion){
        let page = (type == .Subject ? "subject" : "square" )
        let key  = (type == .Subject  ?
            "71E9EDFA30D38D95664AF805400324E1" :
            "093A511B21DC549B1F31F700C8A0400C")
    
      let url = "\(kDISCOVER_BANNER_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&page=\(page)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=\(key)"
        NetworkTool.requestJSON(.GET, URLString: url) { (response) in
            if response?.rtn == "0"
            {
                if let data = response?.data
                {
                   var bannerList = [Banner]()
                    for dict in data["bannerInfoList"] as! [[String:AnyObject]]
                    {
                        bannerList.append(Banner(dict: dict))
                    }
                    completion(bannerList: bannerList)
                }
            } else {
                debugPrint("error: \(response?.codeMsg)")
                completion(bannerList : nil)
            }
        }
    }
    
    
    
    
    

}

