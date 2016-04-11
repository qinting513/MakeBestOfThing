//
//  TopicInfo.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class TopicInfo : NSObject {
    /** 返回点数据 模型属性 */
    var topicID: String?
    var type = 0
    var content: String?
    var resUrl: String?
    var replyTopicID: String?
    var replyUserID: String?
    var stickerID: String?
    var paperID: String?
    var subjectID: String?
    var subjectTitle: String?
    var location: String?
    var userInfo: User?
    var heat = 0
    var praiseCnt = 0
    var duration = 0
    var pubTime: String?
    var recvTime: String?
    var isDiscard = 0
    var simpleSubjectInfoList: SimpleSubjectInfo?
    var commentCnt: String?
    var beauty: String?
    var isTop = 0
    
    //isEnd : 是否有更多数据 sortValue: 下次获取更多的字段
    typealias topicInfoCompletion = (isEnd : Bool, sortValue:String, topicInfoList : [TopicInfo]?) -> ()
    typealias squareTopicInfoCompletion = (topicInfoList : [TopicInfo]?) -> ()
    
    init(dict : [String : AnyObject]?){
         super.init()
        //要么count大于0，否则执行else语句
        guard dict?.count > 0 else{
        return
        }

        for (key,value) in dict! {
        let keyName = key as String

            if keyName == "userInfo"{
                userInfo    = User(dict: value as? [String:AnyObject])
                continue
            }else if keyName == "simpleSubjectInfoList" {
                simpleSubjectInfoList = SimpleSubjectInfo(dict: value as? [String : AnyObject])
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
    
//    override func setValue(value: AnyObject?, forKey key: String) {
//        
//    }
    
//TODO: ［[String: AnyObject]］有2个中括号才正确 ？？why
    /**
     获取首页数据列表
     
     - parameter isFollow:      精选 or 关注
     - parameter order:         1 or 0  1:获取最新 0:获取更多
     - parameter sortValue:     获取更多需要的字段
     */
    class func fetchTopicInfoList(isFollow isFollow: Bool = false, order: Int = 1, sortValue: String = "0", completion: topicInfoCompletion) {
        let baseUrl = isFollow ? kHOME_FOLLOW_TOPIC_LIST_URL : kHOME_TOPIC_LIST_URL
        let url = "\(baseUrl)?\(kAPI_USERID)&baseSortValue=\(sortValue)&\(kAPI_VERSION)&\(kAPI_SYSVERSION)&requestCnt=50&\(kAPI_PRODUCTID)&\(kAPI_SESSION_TOKEN)&\(kAPI_CHANNELID)&\(kAPI_OS)&order=\(order)&\(kAPI_VERSION_CODE)&\(kAPI_PEERID)&\(kAPI_SESSION_ID)&\(kAPI_KEY)"
        
        NetworkTool.requestJSON(.GET, URLString: url) { (response) in
            if response?.rtn == "0" {
                /** 请求成功 */
                if let data = response?.data {
//                    print("网络请求的数据：",data)
                    //创建一个可变数组topicInfoList存放一个个模型
                    var topicInfoList = [TopicInfo]()
                    for dict in data["topicInfoList"] as! [[String: AnyObject]] {
                        
                        topicInfoList.append(TopicInfo(dict: dict))
                    }
                    completion(isEnd: (data["isEnd"] as! Int) == 1, sortValue: data["sortValue"] as? String ?? "0", topicInfoList: topicInfoList)
                }
            }else {
                
                /** 请求失败 */
                debugPrint("error:\(response?.codeMsg)")
                completion(isEnd: true, sortValue: "0", topicInfoList: nil)
            }
        }
    }
    
    class func fetchSubjectTopicList(subjectID subjectID: Int, completion: topicInfoCompletion) {
        let url = "http://api.impingo.me/subject/listSubjectTopic?userID=1404034&baseSortValue=0&version=3.7&sysVersion=9.2.1&requestCnt=20&productID=com.joyodream.pingo&sessionToken=cce76093c4&listType=1&channelID=App%20Store&os=ios&subjectID=343887&versionCode=15&peerID=6EDEE890B4E5&sessionID=e5c8c1b3e8153e78ab&key=B5CADA9605B2C4AADF5069F01CDB7D1C"
     NetworkTool.requestJSON(.GET, URLString: url) { (response) -> () in
        if response?.rtn == "0" {
            if let data = response?.data
            {
            var topicInfoList = [TopicInfo]()
                for dict in data["topicInfoList"] as! [[String:AnyObject]]
                {
                  topicInfoList.append(TopicInfo(dict: dict))
                }
                completion(isEnd: (data["isEnd"] as! Int) == 1, sortValue: data["sortValue"] as? String ?? "0" , topicInfoList: topicInfoList)
            }else{
            debugPrint("fetch error:\(response?.codeMsg)")
                 completion(isEnd: true, sortValue: "0", topicInfoList: nil)
            }
          }
        }
        
    }
    
}
