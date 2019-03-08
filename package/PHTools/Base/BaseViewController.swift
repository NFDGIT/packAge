//
//  BaseViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UINavigationControllerDelegate  {
    var showNavi : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.phNaviTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.phNaviBg
        
        
        self.view.backgroundColor = UIColor.phBgContent
        self.setNeedsStatusBarAppearanceUpdate()

        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    
    
    
    func initUI()  {}
    func initNavi()  {}

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
}


extension BaseViewController{
    // MARK: 导航代理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(!(viewController as! BaseViewController).showNavi, animated: true)
    }
    func dial(phone:String) {
        let callWebview =   UIWebView()
        callWebview.loadRequest(NSURLRequest(url: URL(string: "tel:\(phone)")!) as URLRequest)
        self.view.addSubview(callWebview)
    }

}
