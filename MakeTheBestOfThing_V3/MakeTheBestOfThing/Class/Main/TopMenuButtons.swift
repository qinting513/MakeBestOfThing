//
//  TopMenuButtons.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

protocol TopMenuDelegate : NSObjectProtocol {
    /**
     点击了某个按钮
     
     - parameter topMenu: topMenu
     - parameter index:   按钮index
     */
    func topMenu(topMenu:TopMenuButtons,didClick index : Int);
    
}

class TopMenuButtons: UIView {
    

    @IBOutlet weak var leftButton: QTButton!
    @IBOutlet weak var rightButton: QTButton!
    @IBOutlet weak var indicatotView: UIView!
    weak  var delegate : TopMenuDelegate?
    
    var showText : (String,String)? {
        didSet{
            leftButton.setTitle("\(showText!.0)", forState: .Normal)
            rightButton.setTitle("\(showText!.1)", forState: .Normal)
        }
    }
    
    @IBAction func leftBtnClick(sender: UIButton) {
        btnClick(leftButton)
    }
    @IBAction func rightBtnClick(sender: UIButton) {
        btnClick(rightButton)
    }
    
    var toIndex :  Int = 0 {
        
        didSet{
            guard toIndex <= 2 && toIndex >= -1 else{
                return
            }
            var center = indicatotView.center;
            center.x = toIndex == 1 ? leftButton.center.x : rightButton.center.x
            UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
                self.indicatotView.center = center
                }, completion: nil)
        }
    }
    
    func btnClick(sender:QTButton){
        let index = sender.tag
        guard index != toIndex else{
            return
        }
        
        toIndex = index
        delegate?.topMenu(self, didClick: index)
    }
    
    class func loadFromNib() -> TopMenuButtons{
        return NSBundle.mainBundle().loadNibNamed("TopMenuButtons", owner: self, options: nil).last as! TopMenuButtons
    }
    
    
}
