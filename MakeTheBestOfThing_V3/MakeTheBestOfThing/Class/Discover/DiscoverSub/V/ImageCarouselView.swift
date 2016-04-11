//
//  ImageCarouselView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "ImageCarouselCell"

class ImageCarouselView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!

    @IBOutlet weak var pageControl: UIPageControl!
    
    private var kNumberOfSecctions = 0

    private var timer : NSTimer?
    
    /** 旗帜 标语的数组 */
    var bannerList : [Banner]? {
        didSet{
        collectionView.reloadData()
            
            if bannerList?.count <= 1 {
                collectionView.scrollEnabled = false
                kNumberOfSecctions = 1
            }else {
                collectionView.scrollEnabled = true
                kNumberOfSecctions = 100
            
                collectionViewScrollToCenter()
                
                startTimer()
            }
            pageControl.numberOfPages = bannerList?.count ?? 0
            pageControl.currentPage = 0
        }
    }
    
    //注册cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib( UINib(nibName: "ImageCarouselCell", bundle: nil),
                        forCellWithReuseIdentifier: kCellReuseIdentifier)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = bounds.size
    }
    
    //MARK: - 滚动到中间
    private func collectionViewScrollToCenter() {
    
        guard bannerList != nil else {
           return
        }
//        
//        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0,inSection:
//            Int(kNumberOfSecctions / 2) ) ,atScrollPosition: .Left, animated: false)
    }
    
    //MARK: - 图片轮播
    func scrollImage() {
    let offsetX = collectionView.contentOffset.x
    let toOffsetX = offsetX + CGRectGetWidth(collectionView.bounds)
        if toOffsetX < collectionView.contentSize.width {
           collectionView.setContentOffset(CGPointMake(toOffsetX, 0), animated: true)
        }else{
            collectionViewScrollToCenter()
        }
    }
    
    
    func startTimer() {
        guard timer == nil else{
           return
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "scrollImage", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    class func loadFromNib() -> ImageCarouselView {
    return NSBundle.mainBundle().loadNibNamed("ImageCarousel", owner: self, options: nil).last as! ImageCarouselView
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension ImageCarouselView : UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return kNumberOfSecctions
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! ImageCarouselCell
        cell.banner = bannerList![indexPath.item]
        return cell
    }
    
}

class ImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var topImageView: UIImageView!
    
    var banner : Banner? {
        didSet {
            if let urlStr = banner?.imageUrl{
                if let url = NSURL(string:urlStr){
                    topImageView.kf_setImageWithURL(url)
                }
            }
        }
    }
    
}

//当滑动时 图片停止等
extension ImageCarouselView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds) + 0.5 ) % bannerList!.count
        pageControl.currentPage = page
    }
}



