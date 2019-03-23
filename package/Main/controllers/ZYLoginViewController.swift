//
//  LoginViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Toast_Swift


class ZYLoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "登录"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(back))
    }
    
    override func initUI() {
        super.initUI()
 
        let items : [(leftImg:UIImage?,placeHolder:String)] = [(nil,"请输入用户名"),(nil,"请输入密码")]
        var temTf : PHTextField?
        
        for (index,item) in items.enumerated() {
            let tf : PHTextField = PHTextField.init(placeHolder: item.placeHolder)
            tf.textAlignment = .center
            
            tf.tag = 100 + index
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
        submitBtn.phView(backGroundColor: UIColor.appTheme)
        submitBtn.phLayer(cornerRadius: 5, borderWidth: 0)
        self.view.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo((temTf!.snp.bottom)).offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        submitBtn.phAddTarget(events: .touchUpInside) { (sender) in
            
            let tfName : PHTextField = self.view.viewWithTag(100) as! PHTextField
            let tfPwd  : PHTextField = self.view.viewWithTag(101) as! PHTextField
  
            
            if (tfName.text?.count)! <= 0 {
                self.view.makeToast("用户名不能为空",position:.center)
                return
            }
            if (tfPwd.text?.count)! <= 0{
                self.view.makeToast("密码不能为空",position:.center)
                return
            }
            Request.login(username: tfName.text!, pwd: tfPwd.text!, response: { (success, msg, data) -> (Void) in
                if success {
                    self.back()
                }else{

                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    self.view.makeToast(msg,position:.center)
                })

            })
        
//            Request.login(userName: tfName.text!, password: tfPwd.text!, response: { (success, msg, data) -> (Void) in
//                print("\(msg)")
//                if success {
//                    PHConstant.isLogin = true;
//                    (UIApplication.shared.delegate as! AppDelegate).switchRootVC()
//                }
//            })
            
    
        }
        
        
        
        let rigisterBtn : UIButton = UIButton.init(normalTitle: "注册", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
        self.view.addSubview(rigisterBtn)
        rigisterBtn.snp.makeConstraints { (make) in
            make.top.equalTo((submitBtn.snp.bottom)).offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        rigisterBtn.phAddTarget(events: .touchUpInside) { (sender) in
            
            self.navigationController?.pushViewController(ZYRegisterViewController(), animated: true)

        }
    }
    
    
    @objc func back()  {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: {
        })
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
