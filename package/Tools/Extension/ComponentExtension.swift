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

    static var UITextFieldMarginKey: String = "UITextFieldMarginKey"
    static var UITextFieldSpaceKey: String = "UITextFieldSpaceKey"

    
    
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
    func custom()  {
        let customTabbar : PHTabbarView = PHTabbarView.init()
        self.tabBar.addSubview(customTabbar)
        customTabbar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Bottom_Tool_Height())
        }
    
        let temDatas  = NSMutableArray.init()
        for item in self.tabbarItems! {
            
            let btn : UIButton = UIButton.init(normalTitle: item.title, normalImg: UIImage.init(named: "未选中"), selectedImg: UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red,normalBgImg:UIImage.phInit(color: UIColor.white),selectedBgImg:UIImage.phInit(color: UIColor.phBgContent),font: UIFont.phSmall)
            temDatas.add(btn)
            
    
        }
        
        
        customTabbar.datas = (temDatas as! [UIButton])
        for (index,item) in (customTabbar.datas?.enumerated())! {
            item.phImagePosition(at: index % 2 == 0 ? .top : .bottom, space: SCALE(size: 5))
        }
        
        customTabbar.callBack = { index in
            self.selectedIndex = index
        }
        
        
    }
    
    
}

extension UIButton{
    // MARK: UIButton的初始化方法
     convenience  init(normalTitle:String,selectedTitle:String? = nil,normalImg:UIImage? = nil,selectedImg:UIImage? = nil,normalTextColor:UIColor?,selectedTextColor:UIColor? = nil,normalBgImg:UIImage? = nil,selectedBgImg:UIImage? = nil,font:UIFont?)  {
        self.init()
        
        self.phInitialize(normalTitle: normalTitle, selectedTitle: selectedTitle, normalImg: normalImg, selectedImg: selectedImg, normalTextColor: normalTextColor, selectedTextColor: selectedTextColor,normalBgImg: normalBgImg,selectedBgImg: selectedBgImg, font: font)
    }
    // MARK: UIButton的一些常用参数的初始化
    func  phInitialize(normalTitle:String,selectedTitle:String? = nil,normalImg:UIImage? = nil,selectedImg:UIImage? = nil,normalTextColor:UIColor?,selectedTextColor:UIColor? = nil,normalBgImg:UIImage? = nil,selectedBgImg:UIImage? = nil,font:UIFont?) {

        self.setTitle(normalTitle, for: .normal)
        self.setImage(normalImg, for: .normal)
        self.setTitleColor(normalTextColor, for: .normal)
        self.setBackgroundImage(normalBgImg, for: .normal)
        
        self.setTitle(selectedTitle, for: .selected)
        self.setImage(selectedImg, for: .selected)
        self.setTitleColor(selectedTextColor, for: .selected)
        self.setBackgroundImage(selectedBgImg, for: .selected)
        
        self.titleLabel?.font = font
        
        self.imageView?.contentMode = UIViewContentMode.center
        
    }
    

    
    // MARK: UIButton图像文字同时存在时---图像相对于文字的位置
    /**
     UIButton图像文字同时存在时---图像相对于文字的位置

     - top:    图像在上
     - left:   图像在左
     - right:  图像在右
     - bottom: 图像在下
     */
    enum PHButtonImageEdgeInsetsStyle {
        case top, left, right, bottom
    }
    /// 文字图片互换位置
    ///
    /// - Parameters:
    ///   - style: 样式
    ///   - space: 间距
    func phImagePosition(at style: PHButtonImageEdgeInsetsStyle, space: CGFloat) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
    
        //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height

        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
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
    func phAddTarget(events:UIControlEvents, callBack:@escaping ((UIButton)->()))  {
        self.addTarget(self, action: #selector(temMethod(sender:)), for: events)
        self.eventCallBack = { sender in
            callBack(sender)
        }
    }
    @objc private func temMethod(sender:UIButton)  {
        self.eventCallBack!(sender)
    }
}
extension UIView{

    func phLayer(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor? = nil) {
        if  cornerRadius  != 0{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        if  borderColor != nil {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor!.cgColor
        }
    }
    func phView( backGroundColor:UIColor?) {
        self.backgroundColor = backGroundColor
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

extension UIImage{
    
       static func phInit(color:UIColor) -> UIImage {
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image!
    }
    
    
}
extension UITextField{
//    var space : CGFloat {
//        get {
//            return (objc_getAssociatedObject(self, &ComponentAssociatedKeys.UITextFieldSpaceKey) as! CGFloat)
//        }
//        set {
//            objc_setAssociatedObject(self, &ComponentAssociatedKeys.UITextFieldSpaceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    var margin : CGFloat {
//        get {
//            return (objc_getAssociatedObject(self, &ComponentAssociatedKeys.UITextFieldMarginKey) as! CGFloat)
//        }
//        set {
//            objc_setAssociatedObject(self, &ComponentAssociatedKeys.UITextFieldMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.leftViewRect(forBounds: bounds)
//        rect.origin.x += margin
//        return rect
//    }
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        let x : CGFloat = (self.leftView?.frame.maxX) ?? 0 + space
//        
//        return CGRect.init(x: x, y: bounds.origin.y, width:(self.rightView?.frame.minX) ?? self.frame.width - x - space,  height: bounds.size.height)
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        let x : CGFloat = (self.leftView?.frame.maxX) ?? 0 + space
//        
//        return CGRect.init(x: x, y: bounds.origin.y, width:(self.rightView?.frame.minX) ?? self.frame.width - x - space,  height: bounds.size.height)
//    }
}

