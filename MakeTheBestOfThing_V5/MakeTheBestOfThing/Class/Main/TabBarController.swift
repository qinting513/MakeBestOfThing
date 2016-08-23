//
//  TabBarController.swift
//  PinGo
//
//  Created by Qinting on 16/3/24.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet private weak var aTabBar : TabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        aTabBar.aDelegate = self
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         removeSystemTabbarSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
         removeSystemTabbarSubviews()
    }

    /** 移除掉tabBar的子view >>>变成都是按钮的 */
    private func removeSystemTabbarSubviews() {
        for v in tabBar.subviews {
            if v.superclass == UIControl.self {
            v.removeFromSuperview()
            }
        }
    
    }
    
}

/** 遵守代理TabBarDelegate 实现Tabbar点击事件的代理方法 */
extension TabBarController : TabBarDelegate {

    func tabBar(tabBar: TabBar,var didClickButton index: Int) {
        if index == 2 {
        let showVC = UIStoryboard.initialViewController("Show")
            presentViewController(showVC, animated:true, completion: nil)
        return
            
        }else if index >= 2 {
        index -= 1
        }
        selectedIndex = index
        
    }

}
