//
//  PHBaseTabBarController.swift
//  package
//
//  Created by Admin on 2019/3/4.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHBaseTabBarController: UITabBarController {
    
    
    var tabbarItems: [(normalImg:String,selectedImg:String,title:String,normalTextColor:UIColor?,selectedTextColor:UIColor?,controller:BaseViewController)]?
    
    convenience  init(params:[(normalImg:String,selectedImg:String,title:String,normalTextColor:UIColor?,selectedTextColor:UIColor?,controller:BaseViewController)]?) {
        self.init()
        
        if params != nil {
            tabbarItems = params
        }
        
        let vcs : NSMutableArray = NSMutableArray.init()
        for item in tabbarItems!{
            
            let controller = item.controller
            let navi : BaseNavigationController = BaseNavigationController.init(rootViewController: controller)
            
            navi.tabBarItem.title = item.title
            navi.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:item.normalTextColor as Any], for: .normal)
            navi.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:item.selectedTextColor as Any], for: .selected)
            
            navi.tabBarItem.image = UIImage.init(named: item.normalImg)?.withRenderingMode(.alwaysOriginal)
            
            
            navi.tabBarItem.selectedImage = UIImage.init(named: item.selectedImg)?.withRenderingMode(.alwaysOriginal)
            
            vcs.add(navi)
        }
        self.viewControllers = (vcs as! [UIViewController])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
