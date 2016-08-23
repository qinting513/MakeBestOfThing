//
//  DiscoverHeaderView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

/** 总的头部的headerView 由图片轮播跟2个按钮构成*/

class DiscoverHeaderView: UIView {

    @IBOutlet weak var topView: UIView!
    
    var bannerList : [Banner]? {
        didSet {
        imageCarouselView.bannerList = bannerList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.addSubview(imageCarouselView)
    }
    
    override func layoutSubviews() {
        imageCarouselView.frame = topView.bounds
    }
   
    func scrollImage() {
       imageCarouselView.startTimer()
    }
    
    func stopScrollImage() {
       imageCarouselView.stopTimer()
    }
    
    @IBAction func buttonClick(sender: AnyObject) {
        
    }
   
    class func loadFromNib() -> DiscoverHeaderView {
    return NSBundle.mainBundle().loadNibNamed("DiscoverHeader", owner: self, options: nil).last as! DiscoverHeaderView
    }
    
    // MARK: lazy loading
    private lazy var imageCarouselView : ImageCarouselView = {
    
    let i = ImageCarouselView.loadFromNib()
    
        return i
    
    }()

}
