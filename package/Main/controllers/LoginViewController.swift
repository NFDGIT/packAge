//
//  LoginViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
    }
    override func initUI() {
        super.initUI()
        
        
        let items : [(leftImg:UIImage?,placeHolder:String)] = [(nil,"请输入用户名"),(nil,"请输入密码")]
        var temTf : PHTextField?
        
        for item in items {
            let tf : PHTextField = PHTextField.init(placeHolder: item.placeHolder)
            self.view.addSubview(tf)
            
            
            tf.snp.makeConstraints { (make) in
                
                
                
                if temTf != nil {make.top.equalTo((temTf?.snp.bottom)!).offset(SCALE(size: 10))}
                else{make.top.equalTo(100)}
                
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.height.equalTo(SCALE(size: 50))
                
                temTf = tf
            }
            
            
        }
        
        
        let submitBtn : UIButton = UIButton.init(normalTitle: "登录", normalTextColor: UIColor.white, font: UIFont.phBig)
        submitBtn.phView(backGroundColor: UIColor.red)
        self.view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo((temTf?.snp.bottom)!).offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        submitBtn.phAddTarget(events: .touchUpInside) { (sender) in
            Constant.isLogin = true;
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
