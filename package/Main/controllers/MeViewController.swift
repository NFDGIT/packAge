//
//  MeViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {
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

        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        
        self.title = "我的"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: UIBarButtonItemStyle.done, target: self, action: #selector(setBtnClick))
        
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
extension MeViewController{
    @objc func setBtnClick() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
}
