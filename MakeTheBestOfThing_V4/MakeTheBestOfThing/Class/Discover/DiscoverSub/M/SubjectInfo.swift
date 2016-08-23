//
//  SubjectInfo.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//


import UIKit

/** Discover模型类 */
class SubjectInfo: NSObject {

    var subjectID: String?
    var title: String?
    var desc: String?
    var imageUrl : String?
    var posterUrl: String?
    var topicCnt: Int = 0
    var userCnt: Int = 0
    var isFavo: Int = 0
    var incTopicCnt: Int = 0
    var isActivity: Int = 0
    var activityTitle: String?
    var activityUrl: String?
    var activityUrlType: Int = 0
    var isOfficial: Int = 0
    var readCnt: Int = 0
    
typealias subjectInfoListCompletion = (subjectInfoListArray: [[SubjectInfo]]?) -> ()
typealias subjectInfoCompletion = (subjectInfo:SubjectInfo?, managerUserList: [User]?) -> ()
    
    init(dict: [String : AnyObject]? ){
    
        super.init()
        
        guard dict?.count > 0 else{
        return
        }
/** KVC 字典转模型 */
        for (key,value) in dict! {
        let keyName = key as String
            if keyName == "imageUrl2" {
            self.setValue(value, forKey: keyName)
                continue
            }
            if keyName == "imageUrl" {
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
    
    /** 对关键字key的处理 */
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    /** 网络 GET 请求获取数据  并JSON解析 */
    class func fetchSubjectInfoList(completion : subjectInfoListCompletion){
        
        let url = "\(kDISCOVER_SUBJECTINFO_LIST_URL)?\(kAPI_PEERID)&\(kAPI_OS)&\(kAPI_USERID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_PRODUCTID)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&\(kAPI_SESSION_ID)&\(kAPI_VERSION_CODE)&key=3E21B8BF085CC3287E84A534EACA9DD7"
        /** GET请求，block回调 */
        NetworkTool.requestJSON(.GET, URLString: url)
        { (response) in
            if response?.rtn == "0"
            {
                    // response success
                        if let data = response?.data
                        {
                          var subjectInfoListArray = [[SubjectInfo]]()
                            for categoryDict in  data["subjectCategoryList"] as! [AnyObject]
                            {
                               var subjectInfoList = [SubjectInfo]()
                                for dict in categoryDict["subjectInfoList"] as! [[String: AnyObject]]
                                {
                                    subjectInfoList.append(SubjectInfo(dict: dict))
                                }
                                subjectInfoListArray.append(subjectInfoList)
                            }
                            /** 循环解析完 即可调用completion这个block */
                            completion(subjectInfoListArray: subjectInfoListArray)
                        }
            }else
            {
             debugPrint("SubjectInfo get请求错误:\(response?.codeMsg)")
             completion(subjectInfoListArray: nil)
            }
        }
    }
    
    /** 网络 GET 请求获取数据  并JSON解析 */
    class func fetchSubjectInfo(subjectID subjectID: Int, completion: subjectInfoCompletion) {
        let url = "http://api.impingo.me/subject/getSubject?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&subjectID=343887&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=FD86BF9762791F118EE6E5CDB501B756"
        
        NetworkTool.requestJSON(.GET, URLString: url) { (response) in
            if response?.rtn == "0" {
                if let data = response?.data {
                    if let dict0 = data["subjectInfo"] as? [String: AnyObject] {
                        var managerUserList = [User]()
                        for dict1 in dict0["managerUserInfoList"] as! [AnyObject] {
                            managerUserList.append(User(dict: dict1 as? [String: AnyObject]))
                        }
                        completion(subjectInfo: SubjectInfo(dict: dict0), managerUserList: managerUserList)
                    }else {
                        completion(subjectInfo: nil, managerUserList: nil)
                    }
                }
            }else {
                debugPrint("error:\(response?.codeMsg)")
                completion(subjectInfo: nil, managerUserList: nil)
            }
        }
    }

    
}
