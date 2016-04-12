//
//  String+Extension.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/12.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

extension String {

    static func size(withText text:String, withFont font: UIFont,andMaxSize maxSize:CGSize) ->CGSize{
       return text.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [ NSFontAttributeName: font ], context: nil).size
    
    }
    

}