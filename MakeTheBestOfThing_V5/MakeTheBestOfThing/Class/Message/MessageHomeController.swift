//
//  MessageHomeController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class MessageHomeController: UIViewController {

    @IBOutlet weak var chatContainerView: UIView!
    
    
    @IBOutlet weak var notificationContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = topMenuBtns
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 //MARK: lazy loading
    private lazy var topMenuBtns : TopMenu = {
        let t = TopMenu.loadFromNib()
        t.showText = ("通知","私聊")
        t.delegate = self
        return t
    }()

}

extension MessageHomeController : TopMenuDelegate{

    func topMenu(topMenu: TopMenu, didClickButton index: Int) {
        chatContainerView.hidden = (index != 1)
        notificationContainerView.hidden = !chatContainerView.hidden
    }

}
