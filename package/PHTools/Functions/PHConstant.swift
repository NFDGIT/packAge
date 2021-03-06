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
    
    
    open class var phBgContent: UIColor { get{ return UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)} } //  背景颜色
    
//    字体颜色
    
    /// 红色
    open class var phRed: UIColor { get{ return UIColor.init(red: 231/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)} } //
    ///  黑色字体
    open class var phBlackText: UIColor { get{ return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)} } //
    ///  浅灰色字体
    open class var phLightGrayText: UIColor { get{ return UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)} } //
    ///  导航颜色
    open class var phNaviBg: UIColor { get{ return UIColor.appTheme} }
    ///  导航字体
    open class var phNaviTitle: UIColor { get { return UIColor.white}}
    
}

// MARK: - 字体大小
extension UIFont{
    open class var phBig: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 18))} }   //  大号字体
    open class var phMiddle: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 16))} }   //  中号号字体
    open class var phSmall: UIFont { get{ return UIFont.systemFont(ofSize: SCALE(size: 14))} } //小号字体
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
    static func getRandomNumber(min:Int,max:Int) -> Int {
        let randomNumber:Int = Int(arc4random_uniform(UInt32(max - min))) + min
        return randomNumber
    }
}
