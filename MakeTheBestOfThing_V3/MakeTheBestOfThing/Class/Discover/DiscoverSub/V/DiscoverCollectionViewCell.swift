//
//  DiscoverCollectionViewCell.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var picButton: UIButton!
    @IBOutlet weak var visitorButton: UIButton!
    
    /** 在cell类中 将数据模型类的值赋给label、imageView等 */
    var subjectInfo :SubjectInfo? {
        didSet{
            
            if let urlStr = subjectInfo?.posterUrl {
                if let url = NSURL(string: urlStr){
                imageView.kf_setImageWithURL(url,placeholderImage: UIImage(named: "head_1") )
                }
            }
            
            describeLabel.text = subjectInfo?.title
            
            if let visitorNum = subjectInfo?.readCnt
            {
            visitorButton.setTitle(numToString(visitorNum), forState: .Normal)
            }
            
            if let picNum = subjectInfo?.topicCnt{
            picButton.setTitle(numToString(picNum), forState: .Normal)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 3.0
        layer.masksToBounds = true
    }
    
    private func numToString(num:Int) -> String {
        if num > 999 {
            let kNum = Double(num) / 1000.0
            if kNum > 999 {
                return "999K+"
            }
            return String(format: "%.1f", kNum) + "K"
        }else{
            return String(num)
        }
    }
}
