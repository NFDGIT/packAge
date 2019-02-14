//
//  H5ViewController.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class H5ViewController: BaseWebViewController {
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()

        self.webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com")!))
        
        // Do any additional setup after loading the view.
    }
    override func initUI() {
        super.initUI()
        
        self.showNavi = false

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
     return UIStatusBarStyle.default
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
