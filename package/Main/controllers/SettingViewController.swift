//
//  SettingViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()

        // Do any additional setup after loading the view.
    }
    override func initUI() {
        super.initUI()
        
        let logoutBtn : UIButton = UIButton.init(normalTitle: "退出登录", normalTextColor: UIColor.white, normalBgImg:UIImage.phInit(color: UIColor.red), font: UIFont.phBig)
        self.view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        logoutBtn.phAddTarget(events: .touchUpInside) { (sender) in
            Constant.isLogin = false
            (UIApplication.shared.delegate as! AppDelegate).switchRootVC()
        }
        
        
        
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
