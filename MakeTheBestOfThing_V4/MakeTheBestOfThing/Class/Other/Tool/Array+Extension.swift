//
//  Array+Extension.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/11.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation

extension Array {

    func split(startIndex sIndex:Int, endIndex eIndex : Int) -> [Element] {
        return 0.stride(to: eIndex, by: eIndex).map { _ in
        
              return Array( self[sIndex ..< eIndex])
        }[0]
    }

}