//
//  MeViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class ZYMeViewController: BaseViewController {
    let btnName = UIButton.init()
    
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        self.showNavi = false
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshUI()
        
        
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        
        self.title = "我的"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: UIBarButtonItemStyle.done, target: self, action: #selector(setBtnClick))
        
    }
    func refreshUI() {
        let name = Request.getLocalUserInfo()["user_username"]
        
        
        btnName.setTitle((name as! String), for: .normal)
    }
    override func initUI() {
        super.initUI()
        self.view.backgroundColor = UIColor.white
        
        
        let headBack = UIImageView.init()
        self.view.addSubview(headBack)
        headBack.backgroundColor = UIColor.appTheme
        headBack.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Status_Height()+200)
        }
        
        
        let headImg = UIImageView.init()
        headImg.backgroundColor = UIColor.white
        headBack.addSubview(headImg)
        headImg.layer.cornerRadius = SCALE(size: 35)
        headImg.layer.masksToBounds = true
        headImg.snp.makeConstraints { (make) in
            make.height.width.equalTo(SCALE(size: 70))
            make.center.equalToSuperview()
        }
        headImg.image = UIImage.init(named: "头像.jpg")
        
        

        headBack.addSubview(btnName)
        btnName.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(SCALE(size: 30))
            make.top.equalTo(headImg.snp.bottom)
        }
        
        
        
        let orderStatus : [(String)] = [("待收货"),("配送中")]
        let layoutStatus = PHLayoutView.init()
//        layoutStatus.layout.column = orderStatus.count
        self.view.addSubview(layoutStatus)
        layoutStatus.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headBack.snp.bottom)
        }
        layoutStatus.layout.isAutoHeight = true
        layoutStatus.numberOfCell = {return orderStatus.count}
        layoutStatus.cellForIndex = {index in
            let itemvalue = orderStatus[index]
            
            let view = UIButton.init()
            
            
            let btn : UIButton = UIButton.init(normalTitle: itemvalue, normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
            btn.backgroundColor = UIColor.phBgContent
            btn.isUserInteractionEnabled = false
            
            view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 10))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -10))
                make.height.equalTo(SCALE(size: 60))
            }
            
            btn.contentHorizontalAlignment = .left
            btn.phImagePosition(at: .left, space: SCALE(size: 20))
            
            
            
            
            
            let imgArrow = UIImageView.init(image: UIImage.init(named: "arrow"))
            btn.addSubview(imgArrow)
            imgArrow.contentMode = .center
            imgArrow.snp.makeConstraints { (make) in
                make.width.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(SCALE(size: -10))
            }
            return view
        }
        layoutStatus.selectedCell = {index in
            let order = ZYOrderViewController.init()
            order.type = index
            self.navigationController?.pushViewController(order, animated: true)
            
            if index == 0{
//                let order = QYOrderViewController.init()
//                self.navigationController?.pushViewController(order, animated: true)
            }
            if index == 1{
//                let order = QYOrderViewController.init()
//                self.navigationController?.pushViewController(order, animated: true)
                
            }
        }
        layoutStatus.reload()
        

        
        let itemValues : [(String)] = [("清除缓存"),("去评价"),("关于我们"),("退出登录")]
        let funcItemView : PHLayoutView = PHLayoutView.init()
        self.view.addSubview(funcItemView)
        funcItemView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(layoutStatus.snp.bottom)
        }
        funcItemView.layout.column = 2
        funcItemView.numberOfCell = {return itemValues.count}
        funcItemView.cellForIndex = { index in
            let itemvalue = itemValues[index]
            
            let view = UIButton.init()
         

            
            
            let btn : UIButton = UIButton.init(normalTitle: itemvalue, normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
            btn.backgroundColor = UIColor.phBgContent
            btn.isUserInteractionEnabled = false
            view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 10))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -10))
                make.height.equalTo(SCALE(size: 60))
            }
            
            btn.contentHorizontalAlignment = .left
            btn.phImagePosition(at: .left, space: SCALE(size: 20))
       
   
            

            
            let imgArrow = UIImageView.init(image: UIImage.init(named: "arrow"))
            btn.addSubview(imgArrow)
            imgArrow.contentMode = .center
            imgArrow.snp.makeConstraints { (make) in
                make.width.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(SCALE(size: -10))
            }
            return view
        }
        funcItemView.selectedCell = {index in
            if index == 0
            {
                
                //                    self.view.makeToast("\(PHTool.getCacheSize())",position:.center)
                
                self.view.makeToastActivity(.center)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                    PHTool.removeCache(callBack: { (success) in
                        self.view.makeToast("清除成功",position:.center)
                        self.view.hideToastActivity()
                    })
                })
                
                
                
                
                
                
                
            }
            if index == 1
            {
                
                let url = URL.init(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=\("1454804219")")
                UIApplication.shared.openURL(url!)
                
                
                
            }
            if index == 2
            {
                
                let webVC = PHBaseWebViewController.init()
                
                let fileURL =  Bundle.main.url(forResource: "aboutus", withExtension: "html" )
                webVC.webView.loadFileURL(fileURL!,allowingReadAccessTo:Bundle.main.bundleURL);
                webVC.navigationItem.title = "关于我们"
                
                
                self.view.makeToastActivity(.center)
                Request.getAboutUs(response: { (success, msg, data) -> (Void) in
                    self.view.hideToastActivity()
                    if success {
                        let letus : Dictionary<String,Any> = data["letus"] as! Dictionary<String,Any>
                        var content : String = letus["letus_content"] as! String
                        content = """
                        龙之美装饰是一家装修设计公司，专业提供精美设计方案<br/>
                        设计行业领航者
                        """
                        
                        
                        webVC.webView.loadHTMLString(self.getAboutus(content: content), baseURL: nil)
                        self.navigationController?.pushViewController(webVC, animated: true)
                    }else{
                        self.view.makeToast(msg,position:.center)
                    }
                    
                })
                
                
                
                
                
            }
            if index == 3
            {
                
                let alert =  UIAlertController.init(title: "提示！", message: "确定要退出登录吗？", preferredStyle: .alert)
                let action1 = UIAlertAction.init(title: "确定", style: .destructive, handler: { (alert) in
                    (UIApplication.shared.delegate as! AppDelegate).logout()
                })
                let action2 = UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert) in
                    
                })
                alert.addAction(action2)
                alert.addAction(action1)
                self.present(alert, animated: true, completion: nil)
                
                
                
                
            }

        }
        
        funcItemView.reload()
        
        
        

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
extension ZYMeViewController{

    func getAboutus(content:String) -> String {
        return """
        <html>
        <head>
        <title>关于我们</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body>
        </br>
        <div  style="text-align:center;text-color:orange">
        \(content)
        </div>
        </body>
        </html>
        """
    }
}
