//
//  TopicDetailCollectionViewCell.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/12.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class TopicDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userIconBtn: IBInspectableButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starNumBtn: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var starButton: IBInspectableButton!
    
    /** MVVM --> VM */
    
    var topicInfo : TopicInfo?{
        didSet
        {
            /** 用户头像 */
            if let user = topicInfo?.userInfo
            {
                if let headUrlStr = user.headUrl
                {
                    if let headUrl = NSURL(string: headUrlStr)
                    {
                     userIconBtn.kf_setBackgroundImageWithURL(headUrl, forState: .Normal)
                    }
                }
                /** 用户名 */
               userNameLabel.text = user.nickname
            }
            
            /** 爱心数目 按钮 */
            starButton.setTitle(topicInfo?.commentCnt, forState: .Normal)
            
            /** 背景图片 */
            if let resUrlStr = topicInfo?.resUrl{
                if let resUrl = NSURL(string: resUrlStr){
                bgImageView.kf_setImageWithURL(resUrl)
                }
            }
            
            /** 评论 */
            descLabel.text = topicInfo?.content
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }

    
    
}
