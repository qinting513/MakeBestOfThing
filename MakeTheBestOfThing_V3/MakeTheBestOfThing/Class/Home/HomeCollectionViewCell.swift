//
//  HomeCollectionViewCell.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import Kingfisher

enum HomeCollectionViewCellButtonType : Int {
    case Head = 1
    case Chat = 2//私聊
    case Comment = 3 //评论
    case Star = 4  //star
    case Tag  = 5 //tag
}

protocol HomeCollectionViewCellDelegate : NSObjectProtocol {
    /**
     点击了某个按钮
     
     - parameter cell:      cell
     - parameter button:    按钮
     - parameter btnType:   按钮类型
     - parameter topicInfo: 数据类型
     */
    func homeCollectionViewCell(cell:HomeCollectionViewCell,didClickButton button : UIButton,
        withButtonType btnType:HomeCollectionViewCellButtonType,withTopicInfo topicInfo: TopicInfo)
}


class HomeCollectionViewCell: UICollectionViewCell {

    /// 背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    //头像
    @IBOutlet weak var headButton: IBInspectableButton!
    //tag标签
  
    @IBOutlet weak var tagButton: UIButton!
    
    @IBOutlet weak var headIcon: UIButton!
    //文字描述
    @IBOutlet weak var describeLabel: UILabel!
    //
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    //底部工具栏
    @IBOutlet weak var toolbarView: UIView!
    //评论按钮
    @IBOutlet weak var commentButton: UIButton!
    //star 按钮
    @IBOutlet weak var starButton: UIButton!
    
    weak var homeDelegate : HomeCollectionViewCellDelegate?
    
    //属性监听器
    var topicInfo : TopicInfo?{
        didSet
       {
            /** 背景图 */    /** 如果有URL 如果有值 就赋值 */
                if let bgImageUrlStr = topicInfo?.resUrl
                {
                    if let bgImageUrlStr = NSURL(string: bgImageUrlStr)
                    {
                     bgImageView.kf_setImageWithURL(bgImageUrlStr)
                    }
                }
        
        /** 头像 */
                if let headUrlStr = topicInfo?.userInfo?.headUrl
                {
                   let img = UIImage(named: "home_head")
                    if let headUrl = NSURL(string: headUrlStr)
                    {
                     headButton.kf_setBackgroundImageWithURL(headUrl,
                             forState: .Normal, placeholderImage: img)
                    }else{
                    headButton.setImage(img, forState: .Normal)
                    }
                }
        
        /** user icon */
        if let userHeat = topicInfo?.userInfo?.heat {
            if userHeat == 1 {
                headIcon.hidden = false
                headIcon.setImage(UIImage(named: "home_head_star"), forState: .Normal)
            }else {
                headIcon.hidden = true
            }
        }
        /** tag button */
            if let tagTitle = topicInfo?.subjectTitle
            {
                if tagTitle != ""{
                tagButton.hidden = false
                tagButton.setTitle("#\(tagTitle)", forState: .Normal)
                }else{
                tagButton.hidden = true
                }
            }
        /** describeLabel */
        describeLabel.text = topicInfo?.content
        
        /** 年 月 日 */
        if let pubTime = topicInfo?.pubTime {
        let pubDate = NSDate(timeIntervalSince1970: NSTimeInterval(pubTime)!/1000.0)
            var components = kCalendar.components(.Month, fromDate: pubDate)
            monthLabel.text = "\(components.month)月"
            components = kCalendar.components(.Day, fromDate: pubDate)
            dayLabel.text = "\(components.day)日"
            components = kCalendar.components(.Year, fromDate: pubDate)
            yearLabel.text = "\(components.year)年"
        }
        
/** 评论 */
        if let commentNum = topicInfo?.commentCnt {
            if Int(commentNum) > 999 {
            commentButton.setTitle("999+", forState: .Normal)
            }else if Int(commentNum) == 0  {
            commentButton.setTitle("评论", forState: .Normal)
            }else{
            commentButton.setTitle("\(commentNum)", forState: .Normal)
            }
        }
        
        /** 关注 */
        if let starNum = topicInfo?.praiseCnt {
            if Int(starNum) > 999{
            starButton.setTitle("999+", forState: .Normal)
            }else{
            starButton.setTitle("\(starNum)", forState: .Normal)
            }
         }
        
        
       }
    }
    
    
    /**  重写layout */
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    /** 按钮点击事件 */
    @IBAction func buttonClick(sender: UIButton)
    {
        print("\(sender.tag)")
        homeDelegate?.homeCollectionViewCell(self, didClickButton: sender, withButtonType: HomeCollectionViewCellButtonType(rawValue: sender.tag)!, withTopicInfo: topicInfo!)
    }

    @IBAction func wechatButtonClick(sender: UIButton) {
    }
}


class ToolbarView : UIView{
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: CGRectMake(0, 0, bounds.size.width, 0.2))
        UIColor.lightGrayColor().setFill()
        path.fill()
    }
}