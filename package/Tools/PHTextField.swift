//
//  PHInputView.swift
//  package
//
//  Created by Admin on 2019/2/15.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHTextField : UITextField {
    var space : CGFloat = 10.00
    var margin : CGFloat = 10.00
    
    var limit : Int = 10
}

extension PHTextField{
    convenience init(placeHolder:String, textColor:UIColor? = UIColor.black, font:UIFont? = UIFont.systemFont(ofSize: 12),textAlignment:NSTextAlignment? = .left, leftView:UIView? = nil, rightView:UIView? = nil)
    {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.textAlignment = textAlignment!
        self.placeholder = placeHolder
        self.leftView = leftView
        self.rightView = rightView
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += margin
        return rect
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let x : CGFloat = (self.leftView?.frame.maxX) ?? 0 + space
        return CGRect.init(x: x, y: bounds.origin.y, width:(self.rightView?.frame.minX) ?? self.frame.width - x - space,  height: bounds.size.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let x : CGFloat = (self.leftView?.frame.maxX) ?? 0 + space
        return CGRect.init(x: x, y: bounds.origin.y, width:(self.rightView?.frame.minX) ?? self.frame.width - x - space,  height: bounds.size.height)
    }
    
    
}


