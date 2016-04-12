//
//  DiscoverSubViewController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let kCellReuseIndentifier  = "DiscoverCollectionViewCell"
private let kSectionHeaderViewReuseIdentifier = "SectionHeaderView"
private let kHeaderViewHeight: CGFloat        = 174.0


class DiscoverSubViewController:  UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    private var subjectInfoListArray: [[SubjectInfo]]?
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.backgroundColor = UIColor.whiteColor()
            /** header 头部试图的 加载 */
            collectionView.registerNib(UINib(nibName: "SectionHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier)
            
            collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight - 44, 0, 0, 0)
            collectionView.insertSubview(discoverHeaderView, atIndex: 0)
        
            Banner.fetchBannerList(type: .Subject) { [weak self] (bannerList) in
                if let strongSelf = self {
                    if bannerList != nil{
                       strongSelf.discoverHeaderView.bannerList = bannerList
                    }
                }
            }
        
            SubjectInfo.fetchSubjectInfoList { [weak self] (subjectInfoListArray) in
                if let strongSelf = self {
                    if subjectInfoListArray != nil{
                          strongSelf.subjectInfoListArray = subjectInfoListArray
                           strongSelf.collectionView.reloadData()
                    }
                }
            }
        
        
       }
    
    //MARK： － layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        dispatch_async(dispatch_get_main_queue()) { () in
            self.discoverHeaderView.frame = CGRectMake(0, -kHeaderViewHeight,
                            CGRectGetWidth(self.view.bounds), kHeaderViewHeight)
        }
        
        let width = ( CGRectGetWidth(view.bounds) - 3 * layout.minimumInteritemSpacing) * 0.5
        let height = width * 3.0 / 4.0
        layout.itemSize = CGSizeMake(width, height)
        
    }

    //MARK:
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
          discoverHeaderView.scrollImage()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         discoverHeaderView.stopScrollImage()
    }
        
    //MARK: - lazy load 
    private lazy var discoverHeaderView : DiscoverHeaderView = {
        let h = DiscoverHeaderView.loadFromNib()
        return h
    }()
    
}

//MARK: -  数据源方法
extension DiscoverSubViewController : UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return subjectInfoListArray?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIndentifier, forIndexPath: indexPath) as! DiscoverCollectionViewCell
        
        if let subjectInfoList = subjectInfoListArray?[indexPath.section] {
            if subjectInfoList.count > indexPath.item {
                cell.subjectInfo = subjectInfoList[indexPath.item]
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
    let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier, forIndexPath: indexPath) as! SectionHeaderView
        view.showText = (indexPath.section == 0 ? "热门话题" : "推荐话题")
        return view
        
        }
}


//MARK: delegate方法
extension DiscoverSubViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40)
    }

    
}

//MARK: - 点击 进入详情界面
extension DiscoverSubViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? DiscoverCollectionViewCell {
            if let toVC = segue.destinationViewController as?  TopicDetailController{
            toVC.subjectID = cell.subjectInfo?.subjectID
            toVC.title  = cell.subjectInfo?.title
            }
        }
    }
}
