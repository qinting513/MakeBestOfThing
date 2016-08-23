//
//  QTButton.swift
//  PinGo
//
//  Created by Qinting on 16/3/24.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

/// 取消高亮的button
class QTButton: UIButton {
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            super.highlighted = false
        }
    }
}
