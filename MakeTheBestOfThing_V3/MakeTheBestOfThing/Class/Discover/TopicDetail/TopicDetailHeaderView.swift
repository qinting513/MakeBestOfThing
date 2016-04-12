//
//  TopicDetailHeaderView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class TopicDetailHeaderView: UIView {

    @IBOutlet private weak var backgroundImageView: UIImageView!
 
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var contentLabel: UILabel!
    
    @IBOutlet private var userIconButtons: [IBInspectableButton]!
    
    @IBOutlet private weak var followButton: UIButton!
    
    /** 设置属性 显示出来 */
    var showDataList : (SubjectInfo?,[User]?) {
        didSet{
            if let info = showDataList.0{
                if let bgImageUrlStr = info.imageUrl{
                    if let bgImageUrl = NSURL(string: bgImageUrlStr){
                    backgroundImageView.kf_setImageWithURL(bgImageUrl)
                    }
                }
                titleLabel.text = info.title
                contentLabel.text = info.desc
            }
            
            if let mUser = showDataList.1 {
                var index = 0
                for user in mUser{
                    if let headUrlStr = user.headUrl{
                        guard index < userIconButtons.count else{
                        return
                        }
                        if let headUrl = NSURL(string: headUrlStr){
                        userIconButtons[index].hidden = true
                            userIconButtons[index].kf_setBackgroundImageWithURL(headUrl, forState: .Normal)
                        }
                        index += 1
                    }
                }
            }
            
        }
     }
    
    class func loadFromNib() -> TopicDetailHeaderView{
    return NSBundle.mainBundle().loadNibNamed("TopicDetailHeaderView",
                    owner: self, options: nil).last as! TopicDetailHeaderView
    }
    
    
    @IBAction func userIconButtonClick(sender: AnyObject) {
        print("userIconButtonClick")
    }
    
    @IBOutlet weak var followButtonClick: UIButton!
    
    
}
