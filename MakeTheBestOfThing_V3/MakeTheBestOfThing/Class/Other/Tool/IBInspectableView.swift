//
//  IBInspectableView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/28.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

// @IBDesignable 可以实时渲染
@IBDesignable class IBInspectableView: UIView {
     var kCornerRadius: CGFloat = 0.0
    {
        didSet{
        layer.cornerRadius = kCornerRadius
        layer.masksToBounds = true
        }
     }
}

@IBDesignable class IBInspectableImageView: UIImageView {
    var kCornerRadius: CGFloat = 0.0
        {
        didSet{
            layer.cornerRadius = kCornerRadius
            layer.masksToBounds = true
        }
    }
}

@IBDesignable class IBInspectableButton: UIButton {
    @IBInspectable var kCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = kCornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable var kCanHighlight: Bool = true
    
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            super.highlighted = kCanHighlight
        }
    }
}