//
//  TabBar.swift
//  PinGo
//
//  Created by Qinting on 16/3/24.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

protocol TabBarDelegate : NSObjectProtocol {
/** 点击了某个按钮 */
    func tabBar (tabBar : TabBar, didClickButton index : Int )

}

class TabBar : UITabBar {

    weak var aDelegate : TabBarDelegate?
    
    /** 当前选中的按钮 */
    private var selectedBtn : QTButton?
    
    
    /** awakeFromNib */
    override func awakeFromNib() {
        
        for i in 0..<btnImages.count {
            let imageName = btnImages[i]
            let b = buttonWithImageName(imageName)
            b.tag = i
            if i == 0 {
              buttonClick(b)
            }
            
            addSubview(b)
            buttons.append(b)
        }
    }
    
    /** buttonWithImageName */
    private func buttonWithImageName(imageName : String) -> QTButton {
       let b = QTButton(type: .Custom)
        let sImageName = imageName + "_sel"
        b.setImage(UIImage(named: imageName), forState: .Normal)
        b.setImage(UIImage(named: sImageName),forState: .Selected)
        b.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
        return b;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = buttons.count
        let width = CGRectGetWidth(bounds) / CGFloat(count)
        let height = CGRectGetHeight(bounds)
        
        let frame = CGRectMake(0, 0, width, height)
        for b in buttons{
            b.frame = CGRectOffset(frame, CGFloat(b.tag) * width, 0)
        }
    }
    
    /** 当按钮被点击的时候掉用代理方法通知代理方 */
    func buttonClick (button : QTButton){
        
        guard selectedBtn != button else {
        /** guard 不符合上面的条件 则执行else的部分 */
            return
        }
        
        if button.tag != 2 {
        selectedBtn?.selected = false
            button.selected = true;
            selectedBtn = button
        }
        aDelegate?.tabBar(self, didClickButton: button.tag)
    }
    
    /** 懒加载 */
    private lazy var btnImages : [String] = {
        return ["tabbar_home","tabbar_discover",
            "tabbar_show","tabbar_message","tabbar_profile"]
    }()
    
    private lazy var buttons : [UIButton] = {
        return [UIButton]()
    }()

}
