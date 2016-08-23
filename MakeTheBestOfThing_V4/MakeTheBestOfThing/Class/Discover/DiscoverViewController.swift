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
    t.showText = ("广场","话题")
    t.delegate = self
    return t
    }()
}

extension DiscoverViewController : TopMenuDelegate {
    
    func topMenu(topMenu:TopMenuButtons,didClick index : Int){
     discoverSubContainerView.hidden  = (index == 1)
     topicContainerView.hidden = !discoverSubContainerView.hidden
    }
    
}
