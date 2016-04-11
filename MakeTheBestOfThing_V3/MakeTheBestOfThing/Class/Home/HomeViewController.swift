//
//  HomeViewController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let kCellID = "homeCell"
private let kCellInsets = UIEdgeInsetsMake(15, 15, 15, 15)
private let kToTopicDetailSegue = "home2TopicDetail"

class HomeViewController: UIViewController  {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    private var queryFollowData : Bool = false
    private var baseSortValue : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = topMenu
        
        collectionView?.addSubview(leftRefreshView)
      
        loadData()
        
    }
    /** 重新layout布局 */
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = CGRectGetWidth(view.bounds) - kCellInsets.left - kCellInsets.right;
        let height = CGRectGetHeight(view.bounds) - kCellInsets.top - kCellInsets.bottom 
        layout.itemSize = CGSizeMake(width, height)
    }
    
    func loadData(){
         loadData(.New)
    }
    
    //MARK: - 加载数据
    private func loadData(query:QueryMethod){
        var sortValue : String = ""
        if query == .New {
             sortValue = "0"
        }else{
            sortValue = baseSortValue
        }
        
        TopicInfo.fetchTopicInfoList(isFollow: queryFollowData, order: 1, sortValue: sortValue) { [weak self] (isEnd, sortValue, topicInfoList) in
            if let strongSelf = self {
                if topicInfoList?.count > 0 {
                    strongSelf.baseSortValue = sortValue
                    if query == .New {
                        strongSelf.dataList = topicInfoList!
                    }else {
                        strongSelf.dataList.appendContentsOf(topicInfoList!)
                    }
                    /** 区分是”精选“还是”关注“的逐句 */
                    if strongSelf.queryFollowData {
                        strongSelf.followDataList = strongSelf.dataList
                    }else {
                        strongSelf.topDataList = strongSelf.dataList
                    }
                }
                strongSelf.leftRefreshView.endRefresh()
                strongSelf.collectionView?.reloadData()
            }
        }
    }
    
    
    private lazy var topMenu: TopMenuButtons = {
        let t = TopMenuButtons.loadFromNib()
        t.showText = ("精选", "关注")
        t.delegate = self
        return t
    }()
    
    private lazy var leftRefreshView : LeftRefreshView = {
    let v = LeftRefreshView()
        v.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        return v    
    }()
    
    private lazy var dataList : [TopicInfo] = {
      return [TopicInfo]()
    }()
    
    /** ” 精选 “  数据 */
    private lazy var topDataList : [TopicInfo] = {
      return [TopicInfo]()
    }()
    
        /** ”关注“  数据 */
    private lazy var followDataList : [TopicInfo] = {
     return [TopicInfo]()
    }()

}

//MARK: UICollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellID, forIndexPath: indexPath) as! HomeCollectionViewCell
        cell.homeDelegate = self
        cell.topicInfo = dataList[indexPath.row]
        return cell
    }
    
}

extension HomeViewController : TopMenuDelegate{
    func topMenu(topMenu: TopMenuButtons, didClick index: Int) {
        queryFollowData = (index == 1)
        if followDataList.count > 0 {
            self.dataList = (index == 0) ? self.topDataList : self.followDataList
            self.collectionView.reloadData()
            return
        }
        loadData()
    }
}

extension HomeViewController : HomeCollectionViewCellDelegate {
    func homeCollectionViewCell(cell: HomeCollectionViewCell, didClickButton button: UIButton, withButtonType btnType: HomeCollectionViewCellButtonType, withTopicInfo topicInfo: TopicInfo) {
        switch btnType {
        case .Tag :
            cellDidClickTagButton(topicInfo)
        case .Chat :
            cellDidClickChatButton(topicInfo)
        case .Comment :
            cellDidClickCommentButton(topicInfo)
        default :
            cellDidClickStarButton(topicInfo)
        }
    }
    
    private func cellDidClickTagButton(topicInfo:TopicInfo){
       performSegueWithIdentifier(kToTopicDetailSegue, sender: topicInfo)
    }
    
    private func cellDidClickChatButton(topiInfo: TopicInfo) {
        
    }
    
    private func cellDidClickCommentButton(topiInfo: TopicInfo) {
        
    }
    
    private func cellDidClickStarButton(topiInfo: TopicInfo) {
        
    }

}

extension HomeViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kToTopicDetailSegue {
            if let toVC = segue.destinationViewController as? TopicDetailController  {
//                toVC.subjectID = (sender as! TopicInfo).subjectID
                toVC.title = (sender as! TopicInfo).subjectTitle
            }
        }
    }
}