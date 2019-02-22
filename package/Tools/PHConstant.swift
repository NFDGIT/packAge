//
//  Constant.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHConstant: NSObject {

    
}

/// 尺寸的适配
///
/// - Parameter size: 适配前的尺寸
/// - Returns: 适配后的尺寸
func SCALE(size:CGFloat) -> CGFloat{
//    return size * ((UIScreen.main.bounds.height > 568) ? UIScreen.main.bounds.height/568.00 : 1)
//    return size * (UIScreen.main.bounds.height/568.00)
    return size
}

// MARK: - 颜色
extension UIColor{
    
    
    open class var phBgContent: UIColor { get{ return UIColor.init(red: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1)} } //  背景颜色
    
//    字体颜色
    ///  黑色字体
    open class var phBlackText: UIColor { get{ return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)} } //
    ///  导航颜色
    open class var phNaviBg: UIColor { get{ return UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)} }
    ///  导航字体
    open class var phNaviTitle: UIColor { get{ return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)} }
    
}

// MARK: - 字体大小
extension UIFont{
    open class var phBig: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 16))} }   //  大号字体
    open class var phMiddle: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 14))} }   //  中号号字体
    open class var phSmall: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 12))} } //小号字体
}



func isIPhoneXType() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom == 34
}
func Status_Height() -> CGFloat{//
    return isIPhoneXType() ? 44 : 20
}
func Bottom_Tool_Height() -> CGFloat{//
    return isIPhoneXType() ? 34 : 0
}


extension PHConstant{
    static var isLogin : Bool{
        get{
            return UserDefaults.standard.bool(forKey: "isLogin")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isLogin")
        }
    }
    
}
