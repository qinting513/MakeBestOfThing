//
//  SimpleSubjectInfo.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class SimpleSubjectInfo: NSObject {
    
    var subjectID: String?
    var title: String?
    var isOfficial: String?
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard dict?.count > 0 else {
            return
        }
        
        setValuesForKeysWithDictionary(dict!)
    }
}