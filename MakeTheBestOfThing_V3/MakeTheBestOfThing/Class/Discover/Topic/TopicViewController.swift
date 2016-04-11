//
//  TopicViewController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "TopicCell"

class TopicViewController : UIViewController {

    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var headerView : TopicHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      headerView = TopicHeaderView.loadFromNib()
      tableHeaderView.addSubview(headerView)
        
        tableView.rowHeight = 170.0
        
        /** 网络请求数据 */
        Banner.fetchBannerList(type: .Square) { [weak self ](bannerList) in
            if let strongSelf = self{
                if bannerList != nil{
                strongSelf.headerView.bannerList = bannerList
                }
            }
        }
        
        TopicInfo.fetchTopicInfoList { [weak self ] (isEnd, sortValue, topicInfoList) in
            if let strongSelf = self {
            strongSelf.dataList = topicInfoList!
                /** 刷新表格 */
            strongSelf.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = tableHeaderView.bounds 
    }
    
    //MARK: - lazy loading
    private lazy var headerViewTextList : [String] = {
          return ["热门照片","附近照片","最新照片"]
    }()
 
    private lazy var dataList : [TopicInfo] = {
          return [TopicInfo]()
    }()
    
}




extension TopicViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataList.count > 0 ? headerViewTextList.count : 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuseIdentifier,forIndexPath: indexPath) as! TopicCell
        
        cell.headerViewText = headerViewTextList[indexPath.section]
        
        //将所有的数据分成x份 x ＝ headerViewTextList.count
        let count = dataList.count
        let num = count / headerViewTextList.count
        
        let startIndex = indexPath.section * num
        let endIndex = startIndex + num - 1
        cell.photoInfoList = dataList.split(startIndex : startIndex ,endIndex : endIndex)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
