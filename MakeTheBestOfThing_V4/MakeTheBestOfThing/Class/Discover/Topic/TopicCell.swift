//
//  TopicCell.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "PhotoCell"

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.addSubview(sectionHeaderView)
    }

    /**  重新 布局 */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dispatch_async(dispatch_get_main_queue()) {  () in
            self.sectionHeaderView.frame = self.topView.bounds
        }
        
        let height = CGRectGetHeight(collectionView.bounds)
        layout.itemSize = CGSizeMake(height, height)
    }
    
    var headerViewText : String? {
        didSet{
           sectionHeaderView.showText = headerViewText
        }
    }
    
    var photoInfoList : [TopicInfo]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    //MARK: - 懒加载 sectionHeaderView
    private lazy var sectionHeaderView : SectionHeaderView = {
    return SectionHeaderView.loadFromNib()
    }()
    
}

//MARK:- collectionView的数据源方法
extension TopicCell : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfoList?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        cell.photoInfo = photoInfoList![indexPath.item]
        return cell
    }
}


class PhotoCell : UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var photoInfo : TopicInfo? {
        didSet{
            if let urlStr = photoInfo!.resUrl{
                if let url = NSURL(string: urlStr){
                    imageView.kf_setImageWithURL(url)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }

}


