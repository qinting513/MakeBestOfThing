//
//  DiscoverViewController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var discoverSubContainerView: UIView!
    @IBOutlet weak var topicContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationItem.titleView = topMenuBtns
        
    }

    //MARK: lazy loading
    private lazy var  topMenuBtns: TopMenuButtons = {
    let t = TopMenuButtons.loadFromNib()
    t.showText = ("话题","广场")
    t.delegate = self
    return t
    }()
}

extension DiscoverViewController : TopMenuDelegate {
    
    func topMenu(topMenu:TopMenuButtons,didClick index : Int){
       topicContainerView.hidden  = (index == 1)
       discoverSubContainerView.hidden = !topicContainerView.hidden
        print("选择了button\(index)")
    }
    
}
