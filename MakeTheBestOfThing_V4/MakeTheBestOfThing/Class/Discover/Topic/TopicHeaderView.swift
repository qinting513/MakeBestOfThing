//
//  TopicHeaderView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

protocol TopicHeaderViewDelegate : NSObjectProtocol
{
    /**
     点击了某个按钮
     
     - parameter headView: view
     - parameter button:   按钮
     */
    func topicHeaderView(headView:TopicHeaderView, didClickButton button : UIButton)
}

class TopicHeaderView: UIView {

    @IBOutlet weak var topView: UIView!

    override func awakeFromNib() {
        //topView 添加已经封装好了的图片轮播的一个View到自己上面
        topView.addSubview(imageCarouselView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCarouselView.frame = topView.bounds;
    }
    
    var bannerList : [Banner]? {
        didSet{
        imageCarouselView.bannerList = bannerList
        }
    }
    
    func scrollImage() {
        imageCarouselView.startTimer()
    }
    
    func stopScrollImage() {
        imageCarouselView.stopTimer()
    }
    
    @IBAction func buttonClick(sender : UITapGestureRecognizer){
        if let view = sender.view{
           print(view.tag)
        }
    }
    
    class func loadFromNib() -> TopicHeaderView {
    return NSBundle.mainBundle().loadNibNamed("TopicHeaderView",
                       owner: self, options: nil).last as! TopicHeaderView
    }

    //MARK: - 懒加载 bian liang
    private lazy var imageCarouselView : ImageCarouselView = {
     let i = ImageCarouselView.loadFromNib()
        return i
    }()
    
}
