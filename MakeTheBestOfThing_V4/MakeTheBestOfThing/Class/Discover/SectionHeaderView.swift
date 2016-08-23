//
//  SectionHeaderView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var myLabel: UILabel!
    
    var showText : String? {
        didSet {
        myLabel.text = showText
        }
    }
    
    class func loadFromNib() -> SectionHeaderView {
    return  NSBundle.mainBundle().loadNibNamed("SectionHeaderView", owner: self, options: nil).last as! SectionHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
