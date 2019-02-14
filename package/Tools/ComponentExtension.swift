//
//  ComponentExtent.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import WebKit

class ComponentExtension: NSObject {

}
struct ComponentAssociatedKeys {
    static var tabbarItemsKey: String = "tabbarItemsKey"
    static var buttonEventCallBackKey: String = "buttonEventCallBackKey"
    static var UITableViewCellIndexPathKey: String = "UITableViewCellIndexPathKey"
    
}
extension UIViewController{
    
}
// tabbar  的拓展
extension UITabBarController{//

     var tabbarItems: [(normalImg:String,selectedImg:String,title:String,controller:BaseViewController)]? {
        get {
            let items = objc_getAssociatedObject(self, &ComponentAssociatedKeys.tabbarItemsKey) as? [(normalImg:String,selectedImg:String,title:String,controller:BaseViewController)]
            return items
        }
        set {
            objc_setAssociatedObject(self, &ComponentAssociatedKeys.tabbarItemsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience  init(params:[(normalImg:String,selectedImg:String,title:String,controller:BaseViewController)]?) {
        self.init()

        if params != nil {
            tabbarItems = params
        }

        let vcs : NSMutableArray = NSMutableArray.init()
        for item in tabbarItems!{
            
            let controller = item.controller
            let navi : BaseNavigationController = BaseNavigationController.init(rootViewController: controller)
        
            navi.tabBarItem.title = item.title
            navi.tabBarItem.image = UIImage.init(named: item.normalImg)
            navi.tabBarItem.selectedImage = UIImage.init(named: item.selectedImg)
            
            vcs.add(navi)
        }
        self.viewControllers = (vcs as! [UIViewController])
    }
}

extension UIButton{

 func  initialize(normalTitle:String,selectedTitle:String? = nil,normalImg:UIImage? = nil,selectedImg:UIImage? = nil,normalTextColor:UIColor?,selectedTextColor:UIColor? = nil,font:UIFont?) ->UIButton {
    
        
        self.setTitle(normalTitle, for: .normal)
        self.setImage(normalImg, for: .normal)
        self.setTitleColor(normalTextColor, for: .normal)
        
        self.setTitle(selectedTitle, for: .selected)
        self.setImage(selectedImg, for: .selected)
        self.setTitleColor(selectedTextColor, for: .selected)
        
        self.titleLabel?.font = font
    
        return self
    }
    
    // MARK: --  添加点击事件
    var eventCallBack: ((UIButton)->())? {
        get {
            return objc_getAssociatedObject(self, &ComponentAssociatedKeys.buttonEventCallBackKey) as? ((UIButton) -> ())
        }
        set {
            objc_setAssociatedObject(self, &ComponentAssociatedKeys.buttonEventCallBackKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func addTarget(events:UIControlEvents, callBack:@escaping ((UIButton)->()))  {
        self.addTarget(self, action: #selector(temMethod(sender:)), for: events)
        self.eventCallBack = { sender in
            callBack(sender)
        }
    }
    @objc func temMethod(sender:UIButton)  {
        self.eventCallBack!(sender)
    }
}
extension UIView{
    func layer(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor) -> UIView {
        if  cornerRadius  != 0{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        return self
    }
    func view( backGroundColor:UIColor?) -> UIView {
        self.backgroundColor = backGroundColor
        
        return self
    }
}
extension UITableViewCell{
    var indexPath: IndexPath? {
        get {
            return (objc_getAssociatedObject(self, &ComponentAssociatedKeys.UITableViewCellIndexPathKey) as! IndexPath)
        }
        set {
            objc_setAssociatedObject(self, &ComponentAssociatedKeys.UITableViewCellIndexPathKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
}
