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
    ///  黑色字体
    open class var phBlackText: UIColor { get{ return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)} } //
    ///  浅灰色字体
    open class var phLightGrayText: UIColor { get{ return UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)} } //
    ///  导航颜色
    open class var phNaviBg: UIColor { get{ return UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)} }
    ///  导航字体
    open class var phNaviTitle: UIColor { get { return UIColor.phBlackText}}
    
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
    static func getRandomNumber(min:Int,max:Int) -> Int {
        let randomNumber:Int = Int(arc4random_uniform(UInt32(max - min))) + min
        return randomNumber
    }
}
class PHTool: NSObject {
    static func getCacheSize() ->Double{
        
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath! + ("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (key, fileSize) in floder {
                // 累加文件大小
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).integerValue
                }
            }
        }
        
        let totalCache = Double(size) / 1024.00 / 1024.00
        return totalCache
    }
    static func removeCache(callBack:((_ success:Bool)->())){
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        
        for file in fileArr! {
            
            let path = (cachePath! as NSString).appending("/\(file)")
            
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    
                    try FileManager.default.removeItem(atPath: path)
    
                } catch {
                    
                    
                    
                }
                
            }
            
        }
        callBack(true)

    }
}
