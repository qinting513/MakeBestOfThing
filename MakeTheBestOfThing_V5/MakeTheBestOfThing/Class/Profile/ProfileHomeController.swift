//
//  ProfileHomeController.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class ProfileHomeController: UIViewController {

    
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var headImageView: IBInspectableImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headView.backgroundColor = kAppearanceColor
        
        nameLabel.text = "Bing Bing"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func headViewClick() {
        print("headView")
        
    }

 

}

extension ProfileHomeController : UITableViewDelegate {

}
